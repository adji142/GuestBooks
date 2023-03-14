<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class GeneralModels extends Model
{
    use HasFactory;

    public function isDuplicate($RecordOwnerID, $KeyID, $KeyValue,$Table, $EventID)
    {
        if ($EventID != '') {
            $result = DB::table($Table)
                    ->where($KeyID,$KeyValue)
                    ->where('RecordOwnerID', $RecordOwnerID)
                    ->where('EventID', $EventID)
                    ->count();    
        }
        else{
            $result = DB::table($Table)
                    ->where($KeyID,$KeyValue)
                    ->where('RecordOwnerID', $RecordOwnerID)
                    ->count();
        }
        if ($result > 0) {
            return true;
        }
        else{
        	return false;
        }
    }
}
