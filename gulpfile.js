// run 'npm install' and 'gulp'

var gulp =   require('gulp');
var gutil =  require('gulp-util');
var cjsx =   require('gulp-cjsx');
var coffee = require('gulp-coffee');
var sass =   require('gulp-sass');
var uglify = require('gulp-uglify');
var autoprefixer = require('gulp-autoprefixer');

var paths = {
  styles: {
    src:  'app/scss/**/*.scss',
    dest: 'app/css'
  },
  scripts: {
    src:  'app/coffee/**/*.cjsx',
    dest: 'app/js'
  }
};

gulp.task('styles', function() {
  return gulp.src(paths.styles.src)
    .pipe(sass({errLogToConsole: true}))
    .pipe(autoprefixer(['last 2 versions', "ie 8"]))
    .pipe(gulp.dest(paths.styles.dest));
});

gulp.task('scripts', function() {
  return gulp.src(paths.scripts.src)
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest(paths.scripts.dest));
});

gulp.task('watch', function() {
  gulp.watch(paths.scripts.src, ['scripts']);
  gulp.watch(paths.styles.src, ['styles']);
});

gulp.task('default', ['styles', 'scripts', 'watch']);

