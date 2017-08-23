require 'sinatra'

set :bind, '0.0.0.0'
set :port, 80 

post '/' do
    gitPath = "/opt/blog/checkout"
    repoURL = "git@bitbucket.org:nswebfrog/myblog.git"
    if File.directory?(gitPath)
        gitFetchShell = "cd " + gitPath + " && git fetch origin master && git reset --hard origin/master"
        puts gitFetchShell
        `#{gitFetchShell}`
    else
        gitCloneShell = "git clone " + repoURL + " " + gitPath
        puts gitCloneShell
        `#{gitCloneShell}`
    end

    buildBlogShell = "cd " + gitPath + " && jekyll build" 
    puts buildBlogShell
    `#{buildBlogShell}`

    replaceSiteContentShell = "cd /opt/blog/sites && rm -rf * && cp -r " + gitPath + "/_site/* ." 
    puts replaceSiteContentShell
    `#{replaceSiteContentShell}`

    'Done'
end