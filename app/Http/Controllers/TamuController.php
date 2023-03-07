<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\MessageDefault;
use App\Models\TamuModels;
use App\Models\GeneralModels();

class TamuController extends Controller
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
            $TamuModels = new TamuModels();
            $General = new GeneralModels();

            $formmode = $request->input('formmode');
            $KodeTamu = $request->input('KodeTamu');

            if ($General->isDuplicate($request->input('RecordOwnerID'), 'KodeTamu', $KodeTamu, 'ttamu')) {
                $return['success'] = false;
                $return['nError'] = 101;
                $return['sError'] = "Kode ". $KodeTamu. " Sudah Dipakai! " ;
                return response()->json($return);
            }


            if ($formmode == "delete") {
                 $result = DB::table('bukutamu')
                    ->where('KodeTamu',$KodeTamu)
                    ->count();
                if ($result > 0) {
                    $return['success'] = false;
                    $return['nError'] = 300;
                    $return['sError'] = "Tamu sudah Check IN !" ;
                    return response()->json($return);
                }
            }


            $data = [
                'KodeTamu' => $KodeTamu,
                'NamaTamu' => $request->input('NamaTamu'),
                'KelompokTamu' => $request->input('KelompokTamu'),
                'JumlahUndangan' => $request->input('JumlahUndangan'),
                'AlamatTamu' => $request->input('AlamatTamu'),
                'RecordOwnerID' => $request->input('RecordOwnerID'),
                'EventID' => $request->input('EventID')
            ];

            $save = $TamuModels->storeData($formmode, $KodeTamu, $data,$request->input('RecordOwnerID'));

            if ($save) {
                $sError = 'OK';
            }
            else{
                $sError = 'Gagal Store Data Tamu';
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
        $EventID = $request->input('EventID');
        $Kriteria = $request->input('Kriteria');

        if ($KodeTamu != '') {
            $result = DB::table('ttamu')
                ->select(DB::raw('ttamu.KodeTamu,ttamu.NamaTamu,ttamu.JumlahUndangan,ttamu.AlamatTamu,ttamu.KelompokTamu,tkelompoktamu.NamaKelompok'))
                ->leftjoin('tkelompoktamu','ttamu.KelompokTamu','tkelompoktamu.KodeKelompok')
                ->where('ttamu.RecordOwnerID',$RecordOwnerID)
                ->where('ttamu.KodeTamu',$KodeTamu)
                ->where('ttamu.NamaTamu','LIKE','%'.$Kriteria.'%')
                ->where('ttamu.EventID',$EventID)
                ->get();
        }
        else{
            $result = DB::table('ttamu')
                ->select(DB::raw('ttamu.KodeTamu,ttamu.NamaTamu,ttamu.JumlahUndangan,ttamu.AlamatTamu,tkelompoktamu.NamaKelompok'))
                ->leftjoin('tkelompoktamu','ttamu.KelompokTamu','tkelompoktamu.KodeKelompok')
                ->where('ttamu.RecordOwnerID',$RecordOwnerID)
                ->where('ttamu.NamaTamu','LIKE','%'.$Kriteria.'%')
                ->where('ttamu.EventID',$EventID)
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }
}
