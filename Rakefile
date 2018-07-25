require 'open3'
require 'fileutils'

task :default => :all

LUA_VERSION=51
LUAPATH="c:/dev/lua#{LUA_VERSION}/src"
PY3_VER=37
PY3PATH=ENV["LOCALAPPDATA"]+"/Programs/Python/Python#{PY3_VER}-32"
RB_VER=25
RB_API_VER="2.5.0"
RB_PATH="C:/Ruby#{RB_VER}-x64"

def build_vim(type)
  Dir.chdir(File.join(__dir__, "vim", "src")) do
    cmd = ["make", "-f", "Make_ming.mak",
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
           "RUBY_API_VER_LONG=#{RB_API_VER}"]
    cmd << "GUI=NO" if type == "vim"
    return Open3.capture3(*cmd)
  end
end

desc 'Task description'
task :all => [:git_pull, :gvim, :vim] do
  FileUtils.mv "C:/Vim/vim.exe", "C:/Vim/vim_old.exe"
  FileUtils.mv "C:/Vim/gvim.exe", "C:/Vim/gvim_old.exe"
  FileUtils.mv File.join(__dir__, "vim", "src", "vim.exe"), "C:/Vim/vim.exe"
  FileUtils.mv File.join(__dir__, "vim", "src", "gvim.exe"), "C:/Vim/gvim.exe"
end

task :gvim => :make_clean do |t|
  puts t.name
  _, e, s = build_vim(t.name)
  if s.exited? && s.exitstatus != 0
    puts "unknown exit status!! #{s.exitstatus}"
    puts "error : #{e}"
      next
  end
end

task :vim => :make_clean do |t|
  puts t.name
  _, e, s = build_vim(t.name)
  if s.exited? && s.exitstatus != 0
    puts "unknown exit status!! #{s.exitstatus}"
    puts "error : #{e}"
      next
  end
end

task :make_clean do
  puts "make_clean"
  Dir.chdir(File.join(__dir__, "vim", "src")) do
    _, e, s = Open3.capture3("make -f Make_ming.mak clean")
    if s.exited? && s.exitstatus != 0
      puts "unknown exit status!! #{s.exitstatus}"
      puts "error : #{e}"
        next
    end
  end
end

task :git_pull => :git_clone do
  puts "git_pull"
  Dir.chdir(File.join(__dir__, "vim")) do
    _, e, s = Open3.capture3("git pull")
    if s.exited? && s.exitstatus != 0
      puts "unknown exit status!! #{s.exitstatus}"
      puts "error : #{e}"
        next
    end
  end
end

task :git_clone do
  puts "git_clone"
  _, e, s = Open3.capture3("git clone https://github.com/vim/vim")
  if s.exited? && s.exitstatus != 0 && s.exitstatus != 128
    puts "unknown exit status!! #{s.exitstatus}"
    puts "error : #{e}"
      next
  end
end

