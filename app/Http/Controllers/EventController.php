<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\MessageDefault;
use App\Models\EventModels;

class EventController extends Controller
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
            $EventModels = new EventModels();
            $formmode = $request->input('formmode');
            $KodeEvent = $request->input('KodeEvent');

            $data = [
                'KodeEvent' => $KodeEvent,
                'NamaEvent' => $request->input('NamaEvent'),
                'DeskripsiEvent' => $request->input('DeskripsiEvent'),
                'EstimasiUndangan' => $request->input('EstimasiUndangan'),
                'RecordOwnerID' => $request->input('RecordOwnerID')
            ];

            $save = $EventModels->storeData($formmode, $KodeEvent, $data,$request->input('RecordOwnerID'));

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

        $KodeEvent = $request->input('KodeEvent');
        $RecordOwnerID = $request->input('RecordOwnerID');
        $Kriteria = $request->input('Kriteria');

        if ($KodeEvent != '') {
            $result = DB::table('tevent')
                ->select(DB::raw('tevent.KodeEvent, tevent.NamaEvent, tevent.DeskripsiEvent, tevent.EstimasiUndangan, COALESCE(COUNT(ttamu.EventID),0) AS JumlahTamu'))
                ->leftjoin('ttamu',function ($join)
                {
                	$join->on('ttamu.EventID','=','tevent.KodeEvent')
                	$join->on('ttamu.RecordOwnerID','=','tevent.RecordOwnerID')
                })
                ->where('tevent.RecordOwnerID',$RecordOwnerID)
                ->where('tevent.KodeEvent',$KodeTamu)
                ->where('tevent.NamaEnvent','LIKE','%'.$Kriteria.'%')
                ->orWhere('tevent.DeskripsiEvent','LIKE','%'.$Kriteria.'%')
                ->groupby('tevent.KodeEvent')
                ->get();
        }
        else{
            $result = DB::table('tevent')
                ->select(DB::raw('tevent.KodeEvent, tevent.NamaEvent, tevent.DeskripsiEvent, tevent.EstimasiUndangan, COALESCE(COUNT(ttamu.EventID),0) AS JumlahTamu'))
                ->leftjoin('ttamu',function ($join)
                {
                	$join->on('ttamu.EventID','=','tevent.KodeEvent')
                	$join->on('ttamu.RecordOwnerID','=','tevent.RecordOwnerID')
                })
                ->where('tevent.RecordOwnerID',$RecordOwnerID)
                ->where('tevent.NamaEnvent','LIKE','%'.$Kriteria.'%')
                ->orWhere('tevent.DeskripsiEvent','LIKE','%'.$Kriteria.'%')
                ->groupby('tevent.KodeEvent')
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }
}
