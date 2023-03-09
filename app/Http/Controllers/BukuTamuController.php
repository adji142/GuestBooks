<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\MessageDefault;
use App\Models\GeneralModels;
use App\Models\BukuTamuModels;

class BukuTamuController extends Controller
{
    public function CRUD(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        // $validator = Validator::make($request->all(), [
        //     'KodeTamu' => 'required|max:15',
        //     'NamaTamu' => 'required|max:55',
        //     'KelompokTamu' => 'required',
        //     'JumlahUndangan' => 'required',
        //     'AlamatTamu' => 'required',
        //     'RecordOwnerID' => 'required',
        // ]);

        // if($validator->fails()){
        //     // return response()->json($validator->errors()->toJson(), 400);
        //     $return['success'] = false;
        //     $return['nError'] = 400;
        //     $return['sError'] = response()->json($validator->errors()->toJson());

        //     return response()->json($return);
        // }

        try {
            $BukuTamuModels = new BukuTamuModels();
            $General = new GeneralModels();
            $formmode = $request->input('formmode');
            $RowID = $request->input('RowID');

            $data = [
                'RowID'         	=> $RowID,
                'KodeTamu'         	=> $request->input('KodeTamu'),
                'JumlahUndangan'    => $request->input('JumlahUndangan'),
                'AlamatTamu'  		=> $request->input('AlamatTamu'),
                'EventID'          	=> $request->input('EventID'),
                'RecordOwnerID'     => $request->input('RecordOwnerID')
            ];

            $save = $BukuTamuModels->storeData($formmode, $RowID, $data,$request->input('RecordOwnerID'));

            if ($save) {
                $sError = 'OK';
            }
            else{
                $sError = 'Gagal Isi Buku Tamu';
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
