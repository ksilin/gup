require 'rspec'
require 'spec_helper'

describe 'finding git repos', fakefs: true do

  describe 'simple' do

    before(:each) do
      @root = Dir.mkdir(Dir.pwd + 'repo')
      Dir.chdir(@root[0])
    end

    it 'should identify a dir as a git repo' do

      Dir.mkdir(Dir.pwd + '/.git')

      Dir.glob(Dir.pwd + '/**').each { |f| p "found #{f}" }
      Dir.glob(Dir.pwd + '/**/.git').each { |f| p "found #{f}" }
      is_git_repo = Gup::Main.is_git_repo?(@root[0])
      expect(is_git_repo).to be(true)
    end

    it 'should not confuse a .git file with a .git dir' do

      File.new(Dir.pwd + '/.git', 'a')

      Dir.glob(Dir.pwd + '/**').each { |f| p "found #{f}" }
      Dir.glob(Dir.pwd + '/**/.git').each { |f| p "found #{f}" }
      is_git_repo = Gup::Main.is_git_repo?(@root[0])
      expect(is_git_repo).to be(false)
    end
  end


  describe("nested") do

    it 'finds nested repository' do

      path = Dir.pwd + 'parent/another/repo'
      d = FileUtils.mkdir_p(path)
      p d.inspect
      Dir.chdir(Dir.pwd + '/parent')

      Dir.mkdir(path + '/.git')

      is_git_repo = Gup::Main.is_git_repo?(d[0])
      expect(is_git_repo).to be(false)
    end
  end

  it 'finds all nested repositories' do

    path = Dir.pwd + 'parent/another/repo'
    path2 = Dir.pwd + 'parent/one/repo'
    path3 = Dir.pwd + 'parent/two/repo'
    d = FileUtils.mkdir_p(path)
    d = FileUtils.mkdir_p(path2)
    d = FileUtils.mkdir_p(path3)
    p d.inspect
    Dir.chdir(Dir.pwd + '/parent')

    Dir.mkdir(path + '/.git')

    p "all: #{Gup::Main.find_repos(Dir.pwd)}"
  end

  it 'check whether git up is installed'
  it 'installs git up'

# TODO - what is it supposed to do if there is a git repo under another git repo?
# update all found directories containing a .git dir

# how to check whether the repo has actually been updated?

# when 'git up' is called in a directory containing a .git subdir but without being a git repo
# File "/usr/local/bin/git-up", line 9, in <module>
#     load_entry_point('git-up==1.2.2', 'console_scripts', 'git-up')()
# File "/usr/local/bin/gitup.py", line 581, in run
# gitup = GitUp()
# File "/usr/local/bin/gitup.py", line 136, in __init__
# self.repo = Repo(get_git_dir(), odbt=GitCmdObjectDB)
# File "/usr/local/lib/python2.7/dist-packages/git/repo/base.py", line 126, in __init__
# raise InvalidGitRepositoryError(epath)

end