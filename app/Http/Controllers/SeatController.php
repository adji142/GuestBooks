<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\MessageDefault;
use App\Models\SeatModels;
use App\Models\GeneralModels;

class SeatController extends Controller
{
    public function CRUD(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        // $validator = Validator::make($request->all(), [
        //     'KodeSeat' => 'required|max:15',
        //     'NamaSeat' => 'required|max:55',
        //     'Area' => 'required',
        //     'RecordOwnerID' => 'required',
        // ]);

        // if($validator->fails() && $request->input('formmode') != 'delete' ){
        //     // return response()->json($validator->errors()->toJson(), 400);
        //     $return['success'] = false;
        //     $return['nError'] = 400;
        //     $return['sError'] = response()->json($validator->errors()->toJson());

        //     return response()->json($return);
        // }

        try {
            $SeatModels = new SeatModels();
            $General = new GeneralModels();

            $formmode = $request->input('formmode');
            $KodeSeat = $request->input('KodeSeat');

            if ($General->isDuplicate($request->input('RecordOwnerID'), 'KodeSeat', $KodeSeat, 'tseat')) {
                $return['success'] = false;
                $return['nError'] = 101;
                $return['sError'] = "Kode ". $KodeSeat. " Sudah Dipakai! " ;
                return response()->json($return);
            }
            // Validasi jika sudah dipakai

            if ($formmode == "delete") {
                 $result = DB::table('tkelompoktamu')
                    ->where('KodeSeat',$KodeSeat)
                    ->count();
                if ($result > 0) {
                    $return['success'] = false;
                    $return['nError'] = 300;
                    $return['sError'] = "Data Tempat Duduk Sudah dipakai!" ;
                    return response()->json($return);
                }
            }

            $data = [
                'KodeSeat' => $KodeSeat,
                'NamaSeat' => $request->input('NamaSeat'),
                'Area' => $request->input('Area'),
                'RecordOwnerID' => $request->input('RecordOwnerID')
            ];

            $save = $SeatModels->storeData($formmode, $KodeSeat, $data,$request->input('RecordOwnerID'));

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

        $result = DB::table('tseat as a')
                ->select(DB::raw('a.KodeSeat AS ID, a.NamaSeat AS Title'))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('NamaSeat','LIKE','%'.$Kriteria.'%')
                ->get();

        $return['data'] = $result->toArray();

        return response()->json($return);
    }

    public function Read(Request $request)
    {
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $KodeSeat = $request->input('KodeSeat');
        $RecordOwnerID = $request->input('RecordOwnerID');
        $Kriteria = $request->input('Kriteria');

        if ($KodeSeat != '') {
            $result = DB::table('tseat as a')
                ->select(DB::raw('a.KodeSeat, a.NamaSeat, a.Area'))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('KodeSeat',$KodeSeat)
                ->where('NamaSeat','LIKE','%'.$Kriteria.'%')
                ->get();
        }
        else{
            $result = DB::table('tseat as a')
                ->select(DB::raw('a.KodeSeat, a.NamaSeat, a.Area'))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('NamaSeat','LIKE','%'.$Kriteria.'%')
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }
}
