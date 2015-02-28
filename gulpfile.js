// run 'npm install' and 'gulp'

var gulp = require('gulp');
var gutil = require('gulp-util');
var coffeeReact = require('gulp-coffee-react-transform');
var coffee = require('gulp-coffee');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');
var uglify = require('gulp-uglify');

var paths = {
  styles: {
    src:  'app/scss/**/*.scss',
    dest: 'app/css'
  },
  scripts: {
    src:  'app/coffee/**/*.coffee',
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
    .pipe(coffeeReact())
    .pipe(coffee())
    .on('error', gutil.log)
    .on('error', gutil.beep)
    .pipe(gulp.dest(paths.scripts.dest));
});

gulp.task('watch', function() {
  gulp.watch(paths.scripts.src, ['scripts']);
  gulp.watch(paths.styles.src, ['styles']);
});

gulp.task('default', ['styles', 'scripts', 'watch']);

