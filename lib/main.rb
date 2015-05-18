module Gup
  module Main

    def self.find_repos(dir=Dir.pwd)
      Dir.glob(File.join(dir, '**', '.git/')).map { |repo| File.dirname repo }
    end

    def self.is_repo?(dir)
      false unless File.directory?(dir)
      Dir.entries.grep('.git').size == 1
    end

    def self.update_all(dir = Dir.pwd)
      $stderr.puts "updating all git repos under #{Dir.pwd}"
      find_repos(dir).each { |repo|
        Dir.chdir(repo) { |d|
          $stderr.puts "updating #{d}"
          out = `git up`
          $stderr.puts out
        }
      }
    end

    def self.is_git_repo?(dir, verbose = true)
      false unless File.directory?(dir)
      all_git_files = Dir.glob(File.join(dir, '.git'))
      $stderr.puts "found git directories in #{dir}: #{all_git_files.inspect}" if verbose
      # may still be a git repo, even if it contains a .git dir and a .git file
      just_the_one = all_git_files.size == 1
      just_the_one && File.directory?(all_git_files[0])
    end

    def self.find_repos2(dir = Dir.pwd, recursive = true, verbose = false)
      $stderr.puts "finding all repos under #{dir}" if verbose
      Find.find(dir).select do |f|
        is_repo = is_git_repo? f
        Find.prune if (is_repo || !recursive)
        is_repo
      end
    end


  end
end