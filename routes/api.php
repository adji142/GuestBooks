<?php

use App\Http\Controllers\UserController;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\DemografiController;
use App\Http\Controllers\SeatController;
use App\Http\Controllers\KelompokTamuController;
use App\Http\Controllers\TamuController;
use App\Http\Controllers\EventController;
use App\Http\Controllers\BukuTamuController;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::group([
    'prefix' => 'auth',
],function ($router) {
    Route::post('/login', [UserController::class, 'authenticate']);
    Route::post('/register', [RegisterController::class, 'register']);
    Route::post('/open', [UserController::class, 'open']);
    Route::post('/refresh', [UserController::class, 'RefreshToken']);
    // Route::post('/refresh', ['uses' => 'UserController@RefreshToken', 'middleware' => 'jwt.refresh']); 
});

Route::group([
    'middleware' => ['jwt.verify'],
    'prefix' => 'auth',
], function ($router) {
    // Route::post('/login', [AuthController::class, 'login']);
    // Route::post('/register', [AuthController::class, 'register']);
    // Route::post('/logout', [AuthController::class, 'logout']);
    // Route::post('/refresh', [AuthController::class, 'refresh']);
    // Route::get('/user-profile', [AuthController::class, 'userProfile']);
    // Route::get('/notValidate', [AuthController::class, 'notValidate']);
    Route::post('/user', [UserController::class, 'getAuthenticatedUser']);
    Route::get('/closed', [UserController::class, 'closed']);

    
});

Route::group([
    'prefix' => 'dem',
],function ($router) {
    // Demografi
    Route::post('/readprofinsi', [DemografiController::class, 'ReadProfinsi']);
    Route::post('/readkota', [DemografiController::class, 'ReadKota']);
    Route::post('/readkec', [DemografiController::class, 'ReadKecamatan']);
    Route::post('/readkel', [DemografiController::class, 'ReadKelurahan']);
});

Route::group([
    'prefix' => 'mstr',
],function ($router) {
    // Seat
    Route::post('/seatcrud', [SeatController::class, 'CRUD']);
    Route::post('/seatread', [SeatController::class, 'Read']);
    Route::post('/seatlookup', [SeatController::class, 'GetLookup']);
    // Kelompok Tamu
    Route::post('/kelompoktamucrud', [KelompokTamuController::class, 'CRUD']);
    Route::post('/kelompoktamuread', [KelompokTamuController::class, 'Read']);
    Route::post('/kelompoktamulookup', [KelompokTamuController::class, 'GetLookup']);
    // Tamu
    Route::post('/tamucrud', [TamuController::class, 'CRUD']);
    Route::post('/tamuread', [TamuController::class, 'Read']);
    Route::post('/generateqr', [TamuController::class, 'downloadMultiple']);
    Route::get('/downloadqr/{foldername}/{filename}', [TamuController::class, 'getDownload']);
    // Event Tamu
    Route::post('/eventcrud', [EventController::class, 'CRUD']);
    Route::post('/eventread', [EventController::class, 'Read']);
});

Route::group([
    'prefix' => 'trx',
],function ($router) {
    // BukuTamu
    Route::post('/bukutamu', [BukuTamuController::class, 'CRUD']);
    Route::post('/getnumber', [BukuTamuController::class, 'GetDocumentNumber']);
});