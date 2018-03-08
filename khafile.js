let project = new Project('TenUp');
project.addSources('Sources');
project.addAssets('Assets/**');
project.addLibrary('Kha2D');
resolve(project);
