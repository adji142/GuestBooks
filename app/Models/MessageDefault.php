<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MessageDefault extends Model
{
    use HasFactory;

    public function DefaultMessage()
    {
        // return response()->json(['success'=>false,'nError'=>0,'sError'=> ''], 400);
        return array('success'=>false,'nError'=>0,'sError'=> '', 'data'=>array(),'token'=>'', 'RecordCount'=>0);
    }
}
