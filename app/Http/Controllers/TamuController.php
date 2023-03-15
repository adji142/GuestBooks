<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use File;
use ZipArchive;
use SimpleSoftwareIO\QrCode\Generator;


use App\Models\MessageDefault;
use App\Models\TamuModels;
use App\Models\GeneralModels;
use App\Models\EventModels;

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

            if ($formmode == 'add' && $General->isDuplicate($request->input('RecordOwnerID'), 'KodeTamu', $KodeTamu, 'ttamu',$request->input('EventID'))) {
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
                ->select(DB::raw("ttamu.KodeTamu,ttamu.NamaTamu,ttamu.JumlahUndangan,ttamu.AlamatTamu,COALESCE(ttamu.KelompokTamu, '') AS KelompokTamu,COALESCE(tkelompoktamu.NamaKelompok, 'Unknown') AS NamaKelompok, COALESCE(bukutamu.RowID,0) RowID,bukutamu.JumlahUndangan AS TamuHadir"))
                // ->leftjoin('tkelompoktamu','ttamu.KelompokTamu','tkelompoktamu.KodeKelompok')
                ->leftjoin('tkelompoktamu',function ($join)
                {
                    $join->on('tkelompoktamu.KodeKelompok','=','ttamu.KelompokTamu');
                    $join->on('tkelompoktamu.RecordOwnerID','=','ttamu.RecordOwnerID');
                })
                ->leftjoin('bukutamu',function ($join)
                {
                    $join->on('bukutamu.KodeTamu','=','ttamu.KodeTamu');
                    $join->on('bukutamu.RecordOwnerID','=','ttamu.RecordOwnerID');
                    $join->on('bukutamu.EventID','=','ttamu.EventID');
                })
                ->where('ttamu.RecordOwnerID',$RecordOwnerID)
                ->where('ttamu.KodeTamu',$KodeTamu)
                ->where('ttamu.NamaTamu','LIKE','%'.$Kriteria.'%')
                ->where('ttamu.EventID',$EventID)
                ->get();
        }
        else{
            $result = DB::table('ttamu')
                ->select(DB::raw("ttamu.KodeTamu,ttamu.NamaTamu,ttamu.JumlahUndangan,ttamu.AlamatTamu,COALESCE(ttamu.KelompokTamu, '') AS KelompokTamu,COALESCE(tkelompoktamu.NamaKelompok, 'Unknown') AS NamaKelompok, COALESCE(bukutamu.RowID,0) RowID,bukutamu.JumlahUndangan AS TamuHadir"))
                // ->leftjoin('tkelompoktamu','ttamu.KelompokTamu','tkelompoktamu.KodeKelompok')
                ->leftjoin('tkelompoktamu',function ($join)
                {
                    $join->on('tkelompoktamu.KodeKelompok','=','ttamu.KelompokTamu');
                    $join->on('tkelompoktamu.RecordOwnerID','=','ttamu.RecordOwnerID');
                })
                ->leftjoin('bukutamu',function ($join)
                {
                    $join->on('bukutamu.KodeTamu','=','ttamu.KodeTamu');
                    $join->on('bukutamu.RecordOwnerID','=','ttamu.RecordOwnerID');
                    $join->on('bukutamu.EventID','=','ttamu.EventID');
                })
                ->where('ttamu.RecordOwnerID',$RecordOwnerID)
                ->where('ttamu.NamaTamu','LIKE','%'.$Kriteria.'%')
                ->where('ttamu.EventID',$EventID)
                ->get();
        }

        $return['data'] = $result->toArray();

        return response()->json($return);
    }

    public function downloadMultiple(Request $request)
    {
        $temp = new MessageDefault;
        $return = $temp->DefaultMessage();
        $sError = "";

        $EventModels = new EventModels();

        $RecordOwnerID = $request->input('RecordOwnerID');
        $EventID = $request->input('EventID');

        $event = EventModels::where('KodeEvent',$EventID)->first();

        if ($event) {
            // var_dump($event['NamaEvent']);
            $zip = new ZipArchive;
            $tempName = 'QRDownload/'.$RecordOwnerID.'-'.$EventID.'/';
            $fileName = $tempName."Event QR Download - ".$event['NamaEvent'].".zip";

            File::delete(public_path($fileName));

            try {
                $foldername = public_path($tempName);
                if(!File::isDirectory($foldername)){
                    File::makeDirectory($foldername, 0777, true, true);
                }
                $response = File::makeDirectory($foldername, $mode = 0777, true, true);
                // $response = mkdir($foldername);

                // var_dump($response);

                if ($zip->open(public_path($fileName), ZipArchive::CREATE) === TRUE) {

                    $tamu = TamuModels::where('EventID',$EventID)
                            ->where('RecordOwnerID',$RecordOwnerID)
                            ->get();
                    if ($tamu) {
                        foreach ($tamu as $key) {
                            $this->DownloadQR($tempName.'/'.$key->KodeTamu.' - '.$key->NamaTamu.'.svg',$key->KodeTamu);
                            // $zip->addFile($value, );
                        }
                        $files = File::files(public_path($tempName));

                        foreach ($files as $key => $value) {
                            // var_dump($value);
                            $relativeNameInZipFile = basename($value);
                            $zip->addFile($value, $relativeNameInZipFile);

                            // File::delete($value);
                        }
                        $zip->close();
                        
                        foreach ($tamu as $key) {
                            // $this->DownloadQR($tempName.'/'.$key->KodeTamu.' - '.$key->NamaTamu.'.svg',$key->KodeTamu);
                            // Storage::disk('public')->delete($tempName.'/'.$key->KodeTamu.' - '.$key->NamaTamu.'.svg');
                            File::delete(public_path($tempName.'/'.$key->KodeTamu.' - '.$key->NamaTamu.'.svg'));
                            // $zip->addFile($value, );
                        }
                        // return response()->download(public_path($fileName));
                    }
                    else{
                        $sError = "Tidak Ada Tamu";
                    }
                }
            } catch (Exception $e) {
                $sError = $e->getMessage();
            }
        }
        else{
            $sError = "Event tidak ditemukan";
        }

        if ($sError != '') {
            $return['success'] = false;
            $return['nError'] = 400;
            $return['sError'] = $sError;
        }
        else{
            $return['success'] = true;
            $return['nError'] = 200;
            $return['sError'] = $sError;
        }

        return response()->json($return);
    }
    public function DownloadQR($Path, $data)
    {
        $qrcode = new Generator;
        $path = public_path($Path);
        $qrcode->size(500)->generate($data,$path);
    }
    public function getDownload(Request $request)
    {
        //PDF file is stored under project/public/download/info.pdf
        $Folder = $request->foldername;
        $fileName = $request->filename;

        $file= public_path('QRDownload/'.$Folder.'/'.$fileName.'.zip');

        $headers = array(
          'Content-Type: application/zip',
        );

        return response()->download($file);
    }
}
