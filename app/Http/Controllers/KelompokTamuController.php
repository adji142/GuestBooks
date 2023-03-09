<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\MessageDefault;
use App\Models\KelompokTamuModels;
use App\Models\GeneralModels;
class KelompokTamuController extends Controller
{
    public function CRUD(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        // $validator = Validator::make($request->all(), [
        //     'KodeKelompok' => 'required|max:15',
        //     'NamaKelompok' => 'required|max:55',
        //     'KodeSeat' => 'required',
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
            $KelompokTamuModels = new KelompokTamuModels();
            $General = new GeneralModels();

            $formmode = $request->input('formmode');
            $KodeKelompok = $request->input('KodeKelompok');

            if ($formmode == 'add' && $General->isDuplicate($request->input('RecordOwnerID'), 'KodeKelompok', $KodeKelompok, 'tkelompoktamu')) {
                $return['success'] = false;
                $return['nError'] = 101;
                $return['sError'] = "Kode ". $KodeKelompok. " Sudah Dipakai! " ;
                return response()->json($return);
            }

            if ($formmode == "delete") {
                 $result = DB::table('ttamu')
                    ->where('KelompokTamu',$KodeKelompok)
                    ->count();
                if ($result > 0) {
                    $return['success'] = false;
                    $return['nError'] = 300;
                    $return['sError'] = "Data Kelompok Tamu Sudah dipakai!" ;
                    return response()->json($return);
                }
            }

            $data = [
                'KodeKelompok' => $KodeKelompok,
                'NamaKelompok' => $request->input('NamaKelompok'),
                'KodeSeat' => $request->input('KodeSeat'),
                'RecordOwnerID' => $request->input('RecordOwnerID')
            ];

            $save = $KelompokTamuModels->storeData($formmode, $KodeKelompok, $data, $request->input('RecordOwnerID'));

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

    public function GetLookup(Request $request)
    {
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $RecordOwnerID = $request->input('RecordOwnerID');
        $Kriteria = $request->input('Kriteria');

        $result = DB::table('tkelompoktamu as a')
                ->select(DB::raw('a.KodeKelompok AS ID, a.NamaKelompok AS Title'))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('NamaKelompok','LIKE','%'.$Kriteria.'%')
                ->get();

        $return['data'] = $result->toArray();

        return response()->json($return);
    }

    public function Read(Request $request)
    {
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $KodeKelompok = $request->input('KodeKelompok');
        $RecordOwnerID = $request->input('RecordOwnerID');
        $Kriteria = $request->input('Kriteria');

        if ($KodeKelompok != '') {
            $result = DB::table('tkelompoktamu as a')
                ->select(DB::raw('a.KodeKelompok, a.NamaKelompok, a.KodeSeat,tseat.NamaSeat'))
                ->leftjoin('tseat','a.KodeSeat','tseat.KodeSeat')
                ->where('a.RecordOwnerID',$RecordOwnerID)
                ->where('a.KodeKelompok',$KodeKelompok)
                ->where('a.NamaKelompok','LIKE','%'.$Kriteria.'%')
                ->get();
        }
        else{
            $result = DB::table('tkelompoktamu as a')
                ->select(DB::raw('a.KodeKelompok, a.NamaKelompok, a.KodeSeat,tseat.NamaSeat'))
                ->leftjoin('tseat','a.KodeSeat','tseat.KodeSeat')
                ->where('a.RecordOwnerID',$RecordOwnerID)
                ->where('a.NamaKelompok','LIKE','%'.$Kriteria.'%')
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }
}
