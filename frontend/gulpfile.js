var gulp = require('gulp'),
	less = require('gulp-less'),
    riot = require('gulp-riot'),
    uglify = require('gulp-uglify-es').default,
	sourcemaps = require('gulp-sourcemaps'),
	replace = require('gulp-replace'),
	htmlReplace = require('gulp-html-replace'),
	lessGlob = require('less-plugin-glob'),
    plumber = require('gulp-plumber'),
    cleanCSS = require('gulp-clean-css'),
    concat = require('gulp-concat'),
    del = require('del'),
    imagemin = require('gulp-imagemin'),
    htmlmin = require('gulp-htmlmin'),
    readmin = require('gulp-readmin')
    rename = require('gulp-rename'),
    pkg = require('./package.json');

var destPath = "../static/";
var destTemplatePath = "../templates/";
var random = Math.floor((Math.random() * 10000) + 1);
var appFileMin = 'deeplegal.{version}.{random}.min.{ext}'
        .replace('{version}', pkg.version.replace(/\./gi, '_'))
        .replace('{random}', random.toString());

/**
 * stylesDev
 * Gets all the common and modules' styles and 
 * out puts them into /static/css
 */

gulp.task('stylesDev', function () {
    var destCss = destPath + 'css/';
    return gulp.src(['./styles/*.less', './modules/**/*.less'])
    	.pipe(sourcemaps.init())
        .pipe(plumber())
        .pipe(less({
            plugins: [lessGlob]
        }))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(destCss));
});

/**
 * styles
 * Gets all the common and modules' styles and 
 * out puts them into /static/css minified
 */

gulp.task('styles', function(){
    var destCss = destPath + 'css/';
    return gulp.src(['./styles/*.less', './modules/**/*.less'])
        .pipe(sourcemaps.init())
        .pipe(plumber())
        .pipe(less({
            plugins: [lessGlob]
        }))
        .pipe(cleanCSS({level: {1: {specialComments: 0}}}))
        .pipe(gulp.dest(destCss));

    // var src = ['./styles/*.less', './modules/**/*.less'];
    // var destCss = destPath + 'css/';

    // return gulp.src(src, {base: './'})
    //     .pipe(plumber())
    //     .pipe(less({
    //         plugins: [lessGlob]
    //     }))
    //     .pipe(cleanCSS({level: {1: {specialComments: 0}}}))
    //     .pipe(rename({dirname: destCss}))
    //     .pipe(gulp.dest('./'));
        
});

/**
 * scriptsDev
 * Gets riot tags and common scripts, compile them and
 * out puts them into /static/js
 */

gulp.task('scriptsDev', function () {
    var tagSrc = ['./modules/**/*.tag'],
        jsSrc = './js/*.js',
        destJs = destPath + 'js/';

    gulp.src(tagSrc)
        .pipe(riot())
        .pipe(gulp.dest(destJs));

    return gulp.src(jsSrc)
        .pipe(gulp.dest(destJs));    
});

/**
 * scripts
 * Gets riot tags and common scripts, compile them, 
 * concat commons and out puts them into /static/js. 
 */

gulp.task('scripts', function () {
    var tagSrc = ['./modules/**/*.tag'],
        jsSrc = './django-templates/base/base.html',
        destJs = destPath + 'js/';

    gulp.src(tagSrc)
        .pipe(riot())
        .pipe(uglify({compress: true/*, mangle: {reserved: mangleReservedNames}*/}))
        //.pipe(rename({dirname: destJs}))
        //.pipe(gulp.dest('./'));
        .pipe(gulp.dest(destJs));

    return gulp.src(jsSrc)
        .pipe(replace(/src="\/frontend/g, 'src="../..'))
        .pipe(readmin({type: 'js'}))
        .pipe(uglify({compress: true/*, mangle: {reserved: mangleReservedNames}*/}))
        .pipe(concat(appFileMin.replace('{ext}', 'js')))
        .pipe(gulp.dest(destJs));
});

/**
 * djangoTemplatesDev
 * Moves django templates to /templates and replace
 * src paths for build urls
 */

gulp.task('djangoTemplatesDev', function() {
    var src = './django-templates/**/*.html';

    return gulp.src(src)
        .pipe(replace(/href="\/frontend\/modules/g, 'src="/static/css'))
        .pipe(replace(/src="\/frontend\/modules/g, 'src="/static/js'))
        .pipe(replace(/href="\/frontend/g, 'href="/static'))
        .pipe(replace(/src="\/frontend/g, 'src="/static'))
        .pipe(gulp.dest(destTemplatePath));
})

/**
 * djangoTemplates
 * Moves django templates to /templates, minifies them,
 * and replace src paths for build urls
 */

gulp.task('djangoTemplates', function() {
    
    //base template goes separated since it has common files compressed
    var include = ['./django-templates/**/*.html'];
    var exclude = ['!./django-templates/base/base.html'];
    var src = include.concat(exclude);

    gulp.src(src)
        //replace modules url
        .pipe(replace(/href="\/frontend\/modules/g, 'href="/static/css')) 
        .pipe(replace(/src="\/frontend\/modules/g, 'src="/static/js'))
        //replace other elements - lib
        .pipe(replace(/href="\/frontend/g, 'href="/static'))
        .pipe(replace(/src="\/frontend/g, 'src="/static'))
        .pipe(htmlmin({collapseWhitespace: true}))
        .pipe(gulp.dest(destTemplatePath));

    //build base template

    var htmlreplaceOpt = {
        'css': appFileMin.replace('{ext}', 'css'),
        'js':'js/' + appFileMin.replace('{ext}', 'js'),
        'remove': ''
        //'svg': gulp.src(rootPath + 'images/icons.svg')
    };
    
    return gulp.src('./django-templates/base/base.html')
        .pipe(replace(/href="\/frontend\/styles/g, 'href="/static/css'))
        .pipe(replace(/href="\/frontend/g, 'href="/static'))
        .pipe(replace(/src="\/frontend/g, 'src="/static'))
        .pipe(htmlReplace(htmlreplaceOpt))
        .pipe(htmlmin({collapseWhitespace: true}))
        .pipe(gulp.dest(destTemplatePath + 'base/'));
})

/**
 * libs
 * Moves libs to /static folder 
 * TODO: minify them for prod
 */

gulp.task('libs', function() {
    var libSrc = './lib/**/*',
        destLib = destPath + 'lib/';

    return gulp.src(libSrc)
        .pipe(gulp.dest(destLib));
});

/**
 * images
 * Compress and moves images to /static
 * 
 */

gulp.task('images', function () {
    return gulp.src('./images/**') /*.{jpg,png,gif}*/
        .pipe(imagemin())
        .pipe(gulp.dest(destPath + 'images'));
});


/**
 * Watchers
 * 
 */

// Windows Subsystem for Linux needs to use poll mode (which is high CPU consuming)
var watchOpts = process.env.hasOwnProperty('WATCH_POLL') ? {usePolling: true, mode: 'poll'} : {};

gulp.task('stylesDev:watch', function() {
	gulp.watch(['./styles/*.less', './modules/**/*.less'], watchOpts, gulp.parallel('stylesDev'));
})

gulp.task('scriptsDev:watch', function() {
    var tagSrc = ['./modules/**/*.tag'],
        jsSrc = './js/*.js';

    gulp.watch([tagSrc, jsSrc], watchOpts, gulp.parallel('scriptsDev'));
})

gulp.task('djangoTemplatesDev:watch', function() {
    var src = './django-templates/**/*';
    gulp.watch([src], watchOpts, gulp.parallel('djangoTemplatesDev'));
})

gulp.task('clean', function() {
    return del(['../static/*','../templates/*'], {force: true});
});

/**
 * Build
 * 
 */

gulp.task('watchDev', gulp.parallel('scriptsDev:watch', 'stylesDev:watch', 'djangoTemplatesDev:watch'));

gulp.task('buildDev', gulp.series('clean', gulp.parallel('scriptsDev', 'stylesDev', 'libs', 'djangoTemplatesDev','images')));

gulp.task('buildProd', gulp.series('clean', gulp.parallel('scripts', 'styles', 'libs', 'djangoTemplates', 'images')));

