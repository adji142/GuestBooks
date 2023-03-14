<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\MessageDefault;
use App\Models\EventModels;
use App\Models\GeneralModels;

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
            $General = new GeneralModels();
            $formmode = $request->input('formmode');
            $KodeEvent = $request->input('KodeEvent');

            if ($formmode == 'add' && $General->isDuplicate($request->input('RecordOwnerID'), 'KodeEvent', $KodeEvent, 'tevent','')) {
                $return['success'] = false;
                $return['nError'] = 101;
                $return['sError'] = "Kode ". $KodeEvent. " Sudah Dipakai! " ;
                return response()->json($return);
            }


            if ($formmode == "delete") {
                 $result = DB::table('ttamu')
                    ->where('EventID',$KodeEvent)
                    ->count();
                if ($result > 0) {
                    $return['success'] = false;
                    $return['nError'] = 300;
                    $return['sError'] = "Data Event Sudah Ada tamu!" ;
                    return response()->json($return);
                }
            }

            $data = [
                'KodeEvent'         => $KodeEvent,
                'NamaEvent'         => $request->input('NamaEvent'),
                'DeskripsiEvent'    => $request->input('DeskripsiEvent'),
                'EstimasiUndangan'  => $request->input('EstimasiUndangan'),
                'TglEvent'          => $request->input('TglEvent'),
                'JamEvent'          => $request->input('JamEvent'),
                'LokasiEvent'       => $request->input('LokasiEvent'),
                'RecordOwnerID'     => $request->input('RecordOwnerID')
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
                ->select(DB::raw("tevent.KodeEvent, tevent.NamaEvent, tevent.DeskripsiEvent, tevent.EstimasiUndangan,tevent.TglEvent,tevent.JamEvent,tevent.LokasiEvent, CAST(COALESCE(SUM(CASE WHEN ttamu.KelompokTamu <> '' THEN ttamu.JumlahUndangan ELSE 0 END ),0) AS INT) AS JumlahTamu,CAST(COALESCE(SUM(bukutamu.JumlahUndangan),0) AS INT) AS JumlahTamuDatang"))
                ->leftjoin('ttamu',function ($join)
                {
                	$join->on('ttamu.EventID','=','tevent.KodeEvent');
                	$join->on('ttamu.RecordOwnerID','=','tevent.RecordOwnerID');
                })
                ->leftjoin('bukutamu',function ($join)
                {
                    $join->on('bukutamu.KodeTamu','=','ttamu.KodeTamu');
                    $join->on('bukutamu.EventID','=','tevent.KodeEvent');
                    $join->on('bukutamu.RecordOwnerID','=','tevent.RecordOwnerID');
                })
                ->where('tevent.RecordOwnerID',$RecordOwnerID)
                ->where('tevent.KodeEvent',$KodeEvent)
                ->where('tevent.NamaEvent','LIKE','%'.$Kriteria.'%')
                // ->orWhere('tevent.DeskripsiEvent','LIKE','%'.$Kriteria.'%')
                ->groupby(DB::raw('tevent.KodeEvent, tevent.NamaEvent, tevent.DeskripsiEvent, tevent.EstimasiUndangan,tevent.TglEvent,tevent.JamEvent,tevent.LokasiEvent'))
                ->get();
        }
        else{
            $result = DB::table('tevent')
                ->select(DB::raw("tevent.KodeEvent, tevent.NamaEvent, tevent.DeskripsiEvent, tevent.EstimasiUndangan,tevent.TglEvent,tevent.JamEvent,tevent.LokasiEvent, CAST(COALESCE(SUM(CASE WHEN ttamu.KelompokTamu <> '' THEN ttamu.JumlahUndangan ELSE 0 END),0) AS INT) AS JumlahTamu,CAST(COALESCE(SUM(bukutamu.JumlahUndangan),0) AS INT) AS JumlahTamuDatang"))
                ->leftjoin('ttamu',function ($join)
                {
                	$join->on('ttamu.EventID','=','tevent.KodeEvent');
                	$join->on('ttamu.RecordOwnerID','=','tevent.RecordOwnerID');
                })
                ->leftjoin('bukutamu',function ($join)
                {
                    $join->on('bukutamu.KodeTamu','=','ttamu.KodeTamu');
                    $join->on('bukutamu.EventID','=','tevent.KodeEvent');
                    $join->on('bukutamu.RecordOwnerID','=','tevent.RecordOwnerID');
                })
                ->where('tevent.RecordOwnerID',$RecordOwnerID)
                ->where('tevent.NamaEvent','LIKE','%'.$Kriteria.'%')
                // ->orWhere('tevent.DeskripsiEvent','LIKE','%'.$Kriteria.'%')
                ->groupby(DB::raw('tevent.KodeEvent, tevent.NamaEvent, tevent.DeskripsiEvent, tevent.EstimasiUndangan,tevent.TglEvent,tevent.JamEvent,tevent.LokasiEvent'))
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }
}
