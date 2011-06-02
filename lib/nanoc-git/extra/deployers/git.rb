require 'git'

module NanocGit::Extra::Deployers
  
  # A class for deploying a site using git.
  class Git
    
    # Creates a new deployer that uses git. The deployment configurations
    # will be read from the configuration file of the site (which is assumed
    # to exist).
    #
    # The deployment configurations are stored like this in the site's
    # configuration file:
    #
    #  deploy:
    #    NAME:
    #      dst_remote: origin
    #      dst_branch: master
    #      src_branch: source
    #
    # `NAME` is a unique name for the deployment configuration. By default,
    # the deployer will use the deployment configuration named `"default"`.
    #
    # `DST_REMOTE` is the remote repository to which you are deploying your
    # site.
    #
    # `DST_BRANCH` is the branch to which you are deploying your compiled site.
    #
    # `SRC_BRANCH` is the branch that contains the source files for your site.
    #
    def initialize
      error 'No site configuration found' unless File.file?('config.yaml')
      @site = Nanoc3::Site.new('.')
    end
    
    # Runs the task. Possible params:
    #
    # @option params [String] :config_name (:default) The name of the
    #   deployment configuration to use.
    #
    # @return [void]
    def run(params={})
      source_branch, dest_branch, remote = get_config(params)

      git = ::Git::Base.open('.')

      # Check out the source branch
      puts "Checking out #{source_branch}."
      git.checkout(source_branch)

      # Clean the output dir
      Nanoc3::Tasks::Clean.new(@site).run

      # Compile the site
      puts "Compiling site."
      @site.load_data
      @site.compiler.run

      # Check out the destination branch
      puts "Checking out destination branch."
      git.checkout(dest_branch)

      # Copy output files recursively into the current directory
      puts "Copying files."
      FileUtils.cp_r(@site.config[:output_dir].chomp('/') + '/.', '.')

      # Automatically add and commit changes
      puts "Committing changes."
      git.add
      git.commit("updated #{Time.now.to_s}", :add_all => true)

      # Push changes to the destination repo/branch
      puts "Pushing to #{remote} #{dest_branch}."
      git.push(remote, dest_branch)

      # Switch back to the source branch
      puts "Checking out #{src_branch}."
      git.checkout(source_branch)
    end
    
  private

    # Prints the given message on stderr and exits.
    def error(msg)
      raise RuntimeError.new(msg)
    end

    def get_config(params)
      config_name = params.has_key?(:config_name) ? params[:config_name].to_sym : :default

      # Validate config
      error 'No deploy configuration found'                    if @site.config[:deploy].nil?
      error "No deploy configuration found for #{config_name}" if @site.config[:deploy][config_name].nil?
      
      src_branch = @site.config[:deploy][config_name][:src_branch]
      dst_branch = @site.config[:deploy][config_name][:dst_branch]
      dst_remote = @site.config[:deploy][config_name][:dst_remote]
      
      error 'No source branch found in deployment configuration' if src_branch.nil?
      error 'No destination branch found in deployment configuration' if dst_branch.nil?
      error 'No destination remote found in deployment configuration' if dst_remote.nil?
      
      src_branch, dst_branch, dst_remote
    end

  end
  
end