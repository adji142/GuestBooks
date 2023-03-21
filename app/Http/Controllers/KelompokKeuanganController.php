<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Facade;

use App\Models\MessageDefault;
use App\Models\KelompokKeuanganModels;
use App\Models\GeneralModels;

class KelompokKeuanganController extends Controller
{
    public function CRUD(Request $request){
    	$temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        try {
        	// Validasi jika sudah dipakai

	        // if ($formmode == "delete") {
	        //      $result = DB::table('tkelompoktamu')
	        //         ->where('KodeSeat',$KodeSeat)
	        //         ->count();
	        //     if ($result > 0) {
	        //         $return['success'] = false;
	        //         $return['nError'] = 300;
	        //         $return['sError'] = "Data Tempat Duduk Sudah dipakai!" ;
	        //         return response()->json($return);
	        //     }
	        // }

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

        $result = DB::table('tkelompokkeuangan as a')
                ->select(DB::raw('a.id AS ID, a.NamaKelompok AS Title'))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('EventID',$EventID)
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

        $id = $request->input('id');
        $RecordOwnerID = $request->input('RecordOwnerID');
        $EventID = $request->input('EventID');
        $Kriteria = $request->input('Kriteria');

        if ($id != '') {
            $result = DB::table('tkelompokkeuangan as a')
                ->select(DB::raw("a.id, a.NamaKelompok, CASE WHEN a.Posisi = 0 THEN 'Pengeluaran' ELSE 'Pemasukan' END Posisi, a.Icon "))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('id',$id)
                ->where('EventID',$EventID)
                ->where('NamaKelompok','LIKE','%'.$Kriteria.'%')
                ->get();
        }
        else{
            $result = DB::table('tkelompokkeuangan as a')
                ->select(DB::raw("a.id, a.NamaKelompok, CASE WHEN a.Posisi = 0 THEN 'Pengeluaran' ELSE 'Pemasukan' END Posisi, a.Icon "))
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('EventID',$EventID)
                ->where('NamaKelompok','LIKE','%'.$Kriteria.'%')
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }
}
