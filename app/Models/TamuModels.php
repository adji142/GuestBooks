<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class TamuModels extends Model
{
    use HasFactory;
    protected $table = 'ttamu';

    public function storeData($mode, $id, $data,$RecordOwnerID)
    {
        $created = [
                'created_at' => date('Y-m-d H:i:s')
            ];
        $updated = [
                'updated_at' => date('Y-m-d H:i:s')
            ];
        if ($mode == 'add') {
            $store = DB::table($this->table)->insert(array_merge($data, $created));
            return $store;
        } else if ($mode == 'edit') {
            try {
                $store = DB::table($this->table)
                        ->where('KodeTamu', $id)
                        ->where('RecordOwnerID', $RecordOwnerID)
                        ->update(array_merge($data, $updated));
                return $store;
            } catch (\Illuminate\Database\QueryException $ex) {
                if($ex->getCode() === '23000') {
                    return false;
                }
            }
        } else if ($mode == 'delete') {
            try {
                $store = DB::table($this->table)
                ->where('KodeTamu', $id)
                ->where('RecordOwnerID',$RecordOwnerID)
                ->where('EventID',$data["EventID"])
                ->delete();
                return $store;
            } catch (Exception $e) {
                if($ex->getCode() === '23000') {
                    return false;
                }
            }
        }else {
            return false;
        }
    }
}
