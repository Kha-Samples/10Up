let project = new Project('TenUp');
project.addSources('Sources');
project.addAssets('Assets/Blobs/*');
project.addAssets('Assets/Fonts/*');
project.addAssets('Assets/Sounds/*');
project.addAssets('Assets/Graphics/*');
project.addAssets('Assets/Graphics2x/*', {scale: 2.0});
project.addLibrary('Kha2D');
resolve(project);
