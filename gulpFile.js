const gulp = require('gulp');
const concat = require('gulp-concat');

const INTERMEDIATE_DIR = `${__dirname}/build/`;

/**
 * gulp generate:db:ddl - merges all ddd/*.sql into a single ddl.sql in the build/intermediate directory
 */
 gulp.task('generate:db:ddl', function () {
    return gulp.src("./db/ddl/**.sql")
        .pipe(concat("ddl.sql"))
        .pipe(gulp.dest(INTERMEDIATE_DIR));
});

/**
 * gulp generate:db:sp - merges all dml/sp/*.sql into a single sp.sql in the build/intermediate directory
 */
gulp.task('generate:db:dml:sp', function () {
    return gulp.src("./db/dml/sp/**.sql")
        .pipe(concat("sp.sql"))
        .pipe(gulp.dest(INTERMEDIATE_DIR));
});