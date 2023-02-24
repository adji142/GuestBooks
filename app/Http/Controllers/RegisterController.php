<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Illuminate\Support\Facades\DB;

use App\Models\User;
use App\Models\RegisterModels;
use App\Models\MessageDefault;

class RegisterController extends Controller
{
    public function register(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $validator = Validator::make($request->all(), [
            'CompanyName' => 'required|string|max:255',
            'PICName' => 'required|string|max:255',
            'Email' => 'required|string|Email|max:255|unique:tcompany',
            'password' => 'required|string|min:6|confirmed',
        ]);

        if($validator->fails()){
            // return response()->json($validator->errors()->toJson(), 400);
            $return['success'] = false;
            $return['nError'] = 400;
            $return['sError'] = response()->json($validator->errors()->toJson());

            return response()->json($return);
        }

        DB::beginTransaction();

        try {
            $RegisterModels = new RegisterModels;
            $formmode = $request->input('formmode');
            $id = $request->input('id');

            $data = [
                'id' => $request->input('id'),
                'CompanyName' => $request->input('CompanyName'),
                'Address' => $request->input('Address'),
                'Coordinat' => $request->input('Coordinat'),
                'PICName' => $request->input('PICName'),
                'Email' => $request->input('Email'),
                'PhoneNumber' => $request->input('PhoneNumber'),
                'PartnerCode' => $request->input('PartnerCode'),
                'IddentityID' => $request->input('IddentityID'),
            ];

            $save = $RegisterModels->storeData($formmode, $id, $data);
            if ($save) {
                $user = User::create([
                    'name' => $request->input('PICName'),
                    'email' => $request->input('Email'),
                    'password' => Hash::make($request->input('password')),
                ]);

                if ($user) {
                    $token = JWTAuth::fromUser($user);

                    $save = User::where('email','=',$request->input('Email'))->update(array('remember_token' => $token));

                    if ($save) {
                        $sError = 'OK';
                    }
                    else{
                        $sError = 'Gagal Update Data Token';
                    }
                }
                else{
                    $sError = 'Gagal Store Data User';
                }

            }
            else{
                $sError = 'Gagal Store Data Perusahaan';
            }
        } catch (Exception $e) {
            $sError = 'Error : '.$e->getMessage();
        }

        if ($sError == 'OK') {
            $return['success'] = true;
            $return['nError'] = 200;
            $return['sError'] = "";

            DB::commit();
        }
        else{
            $return['success'] = false;
            $return['nError'] = 400;
            $return['sError'] = $sError;

            DB::rollback();
        }

        return response()->json($return);
    }

}
