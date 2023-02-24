<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Models\MessageDefault;
class DemografiController extends Controller
{
    public function ReadProfinsi(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $Kriteria = $request->input('Kriteria');

        $result = DB::table('dem_provinsi')
            ->select(DB::raw('prov_id ID, prov_name Title'))
            ->where('prov_name','LIKE','%'.$Kriteria.'%')
            ->get();

        $return['data'] = $result->toArray();

        return response()->json($return);
    }

    public function ReadKota(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        // Middleware
        
        $ProvID = $request->input('ProvID');
        $Kriteria = $request->input('Kriteria');

        $result = DB::table('dem_kota')
            ->select(DB::raw('city_id ID, city_name Title'))
            ->where('prov_id','=',$ProvID)
            ->where('city_name','LIKE','%'.$Kriteria.'%')
            ->get();

        $return['data'] = $result->toArray();

        return response()->json($return);
    }

    public function ReadKecamatan(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $KotaID = $request->input('KotaID');
        $Kriteria = $request->input('Kriteria');

        $result = DB::table('dem_kecamatan')
            ->select(DB::raw('dis_id ID, dis_name Title'))
            ->where('city_id','=',$KotaID)
            ->where('dis_name','LIKE','%'.$Kriteria.'%')
            ->get();

        $return['data'] = $result->toArray();

        return response()->json($return);
    }

    public function ReadKelurahan(Request $request){
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $KecID = $request->input('KecID');
        $Kriteria = $request->input('Kriteria');

        $result = DB::table('dem_kelurahan')
            ->select(DB::raw('subdis_id ID, subdis_name Title'))
            ->where('dis_id','=',$KecID)
            ->where('subdis_name','LIKE','%'.$Kriteria.'%')
            ->get();

        $return['data'] = $result->toArray();

        return response()->json($return);
    }
}
