require 'open3'
require 'fileutils'

task :default => :all

LUA_VERSION=51
LUAPATH="c:/dev/lua#{LUA_VERSION}/src"
PY3_VER=37
PY3PATH=ENV["LOCALAPPDATA"]+"/Programs/Python/Python#{PY3_VER}"
RB_VER=26
RB_API_VER="2.6.0"
RB_PATH="C:/Ruby#{RB_VER}-x64"

def build_vim(type)
  cmd = ["make", "-f", "Make_cyg_ming.mak",
         "TERMINAL=yes",
         "STATIC_STDCPLUS=yes",
         "DEBUG=no",
         "LUA=#{LUAPATH}",
         "DYNAMIC_LUA=yes",
         "LUA_VER=#{LUA_VERSION}",
         "PYTHON3=#{PY3PATH}",
         "DYNAMIC_PYTHON3=yes",
         "PYTHON3_VER=#{PY3_VER}",
         "RUBY=#{RB_PATH}",
         "DYNAMIC_RUBY=yes",
         "RUBY_VER=#{RB_VER}",
         "RUBY_API_VER_LONG=#{RB_API_VER}",
         "VIMDLL=yes"]
  return cmd
end

def exec(cmd)
  Open3.popen3(*cmd) do |i, o, e, w|
    i.close
    print o.read
    s = w.value
    if s.exited? && s.exitstatus != 0 && s.exitstatus != 128
      puts "unknown exit status!! #{s.exitstatus}"
      puts "error : #{e.read}"
      next
    end
  end
end

desc 'Task description'
task :all => [:git_pull, :gvim, :vim] do
  begin
    original = File.join(__dir__, "original", "*")
    build = File.join(__dir__, "build", Time.now.strftime("%Y%m%d"))
    FileUtils.mkdir_p build
    FileUtils.cp_r(Dir.glob(original), build, {:remove_destination => true})
    FileUtils.mv File.join(__dir__, "vim", "src", "vim.exe"), build
    FileUtils.mv File.join(__dir__, "vim", "src", "gvim.exe"), build
    FileUtils.mv File.join(__dir__, "vim", "src", "vim64.dll"), build

    runtime_src = File.join(__dir__, "vim", "runtime", "*")
    runtime_dest = File.join(build, "vim82")
    FileUtils.mkdir_p runtime_dest
    FileUtils.cp_r(Dir.glob(runtime_src), runtime_dest)
    link = 'C:\Vim'
    build = build.gsub("/", "\\")
    FileUtils.rm(link, {:force => true})
    cmd = %|sudo cmd /c mklink /D #{link} "#{build}"|
    p cmd
    system(cmd)
  end
end

task :gvim => :make_clean do |t|
  puts t.name
  Dir.chdir(File.join(__dir__, "vim", "src")) do
    # exec(build_vim(t.name))
  end
end

task :vim => :make_clean do |t|
  puts t.name
  Dir.chdir(File.join(__dir__, "vim", "src")) do
    exec(build_vim(t.name))
  end
end

task :make_clean do
  puts "make_clean"
  Dir.chdir(File.join(__dir__, "vim", "src")) do
    exec("cd")
    exec("make -f Make_cyg_ming.mak clean")
  end
end

task :git_pull => :git_clone do
  puts "git_pull"
  Dir.chdir(File.join(__dir__, "vim")) do
    exec("git pull")
  end
end

task :git_clone do
  puts "git_clone"
  exec("git clone https://github.com/vim/vim")
end

