<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\MessageDefault;
use App\Models\TamuModels;
class TamuController extends Controller
{
    public function CRUD(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $validator = Validator::make($request->all(), [
            'KodeTamu' => 'required|max:15',
            'NamaTamu' => 'required|max:55',
            'KelompokTamu' => 'required',
            'JumlahUndangan' => 'required',
            'AlamatTamu' => 'required',
            'RecordOwnerID' => 'required',
        ]);

        if($validator->fails()){
            // return response()->json($validator->errors()->toJson(), 400);
            $return['success'] = false;
            $return['nError'] = 400;
            $return['sError'] = response()->json($validator->errors()->toJson());

            return response()->json($return);
        }

        try {
            $TamuModels = new TamuModels();
            $formmode = $request->input('formmode');
            $KodeTamu = $request->input('KodeTamu');

            $data = [
                'KodeTamu' => $KodeTamu,
                'NamaTamu' => $request->input('NamaTamu'),
                'KelompokTamu' => $request->input('KelompokTamu'),
                'JumlahUndangan' => $request->input('JumlahUndangan'),
                'AlamatTamu' => $request->input('AlamatTamu'),
                'RecordOwnerID' => $request->input('RecordOwnerID')
            ];

            $save = $TamuModels->storeData($formmode, $KodeTamu, $data);

            if ($save) {
                $sError = 'OK';
            }
            else{
                $sError = 'Gagal Store Data Seat';
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

    public function Read(Request $request)
    {
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $KodeTamu = $request->input('KodeTamu');
        $RecordOwnerID = $request->input('RecordOwnerID');
        $Kriteria = $request->input('Kriteria');

        if ($KodeTamu != '') {
            $result = DB::table('ttamu')
                ->select(DB::raw('ttamu.KodeTamu,ttamu.NamaTamu,ttamu.JumlahUndangan,ttamu.AlamatTamu,tkelompoktamu.NamaKelompok'))
                ->leftjoin('tkelompoktamu','ttamu.KelompokTamu','tkelompoktamu.KodeKelompok')
                ->where('ttamu.RecordOwnerID',$RecordOwnerID)
                ->where('ttamu.KodeTamu',$KodeTamu)
                ->where('ttamu.NamaTamu','LIKE','%'.$Kriteria.'%')
                ->get();
        }
        else{
            $result = DB::table('ttamu')
                ->select(DB::raw('ttamu.KodeTamu,ttamu.NamaTamu,ttamu.JumlahUndangan,ttamu.AlamatTamu,tkelompoktamu.NamaKelompok'))
                ->leftjoin('tkelompoktamu','ttamu.KelompokTamu','tkelompoktamu.KodeKelompok')
                ->where('ttamu.RecordOwnerID',$RecordOwnerID)
                ->where('ttamu.NamaTamu','LIKE','%'.$Kriteria.'%')
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }
}
