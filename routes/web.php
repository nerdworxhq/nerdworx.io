<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Home');
})->name('home');

Route::get('/services', function () {
    return Inertia::render('Services');
})->name('services');

Route::get('/products', function () {
    return Inertia::render('Products');
})->name('products');

Route::get('/projects', function () {
    return Inertia::render('Projects');
})->name('projects');

Route::get('/contact', function () {
    return Inertia::render('Contact');
})->name('contact');

Route::get('/docs', function () {
    return Inertia::render('Docs');
})->name('docs');

/* Route::get('/products/clickable-demo', function () {
    return Inertia::render('ClickableDemo');
})->name('clickable-demo');

Route::get('/products/cv-share', function () {
    return Inertia::render('CV-Share');
})->name('cv-share'); */

/* Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard'); */
