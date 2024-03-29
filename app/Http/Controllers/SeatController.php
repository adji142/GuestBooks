<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Facade;

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

            if ($formmode == 'add' && $General->isDuplicate($request->input('RecordOwnerID'), 'KodeSeat', $KodeSeat, 'tseat',$request->input('EventID'))) {
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
                'KodeSeat'  => $KodeSeat,
                'NamaSeat'  => $request->input('NamaSeat'),
                'Area'      => $request->input('Area'),
                'EventID'   => $request->input('EventID'),
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
        }
        else{
            $return['success'] = false;
            $return['nError'] = 400;
            $return['sError'] = $sError;
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
        $EventID = $request->input('EventID');

        $result = DB::table('tseat as a')
                ->select(DB::raw('a.KodeSeat AS ID, a.NamaSeat AS Title'))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('EventID',$EventID)
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
        $EventID = $request->input('EventID');
        $Kriteria = $request->input('Kriteria');

        if ($KodeSeat != '') {
            $result = DB::table('tseat as a')
                ->select(DB::raw('a.KodeSeat, a.NamaSeat, a.Area'))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('KodeSeat',$KodeSeat)
                ->where('EventID',$EventID)
                ->where('NamaSeat','LIKE','%'.$Kriteria.'%')
                ->get();
        }
        else{
            $result = DB::table('tseat as a')
                ->select(DB::raw('a.KodeSeat, a.NamaSeat, a.Area'))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('EventID',$EventID)
                ->where('NamaSeat','LIKE','%'.$Kriteria.'%')
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }

    public function TestDatabase(Request $request)
    {
        echo env('DB_HOST', 'Laravel');
        try {
            \DB::connection()->getPDO();
            echo \DB::connection()->getDatabaseName();
            } catch (\Exception $e) {
            echo 'None';
        }
    }
}
