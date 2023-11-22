<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try{
            $user = User::create($request->all());
            return response()->json([
                "status" => true,
                "message" => 'Berhasil Register',
                "data" => $user,
            ], 200);
        }catch(\Exception $e){
            return response()->json([
                "status" => false,
                "message" => $e->getMessage(),
                "data" => [],
            ], 400);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        try{
            $user = User::find($id);

            if(!$user) throw new \Exception("User tidak ditemukan");
            
            return response()->json([
                "status" => true,
                "message" => 'Berhasil ambil data',
                "data" => $user,
            ], 200);
        }catch(\Exception $e){
            return response()->json([
                "status" => false,
                "message" => $e->getMessage(),
                "data" => [],
            ], 400);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        try{
            $user = User::find($id);

            if(!$user) throw new \Exception("User tidak ditemukan");

            $user->update($request->all());

            return response()->json([
                "status" => true,
                "message" => 'Berhasil update data',
                "data" => $user,
            ], 200);
        }
        catch(\Exception $e){
            return response()->json([
                "status" => false,
                "message" => $e->getMessage(),
                "data" => []
            ], 400);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try{
            $user = User::find($id);

            if(!$user) throw new \Exception("User tidak ditemukan");

            $user->delete();

            return response()->json([
                "status" => true,
                "message" => 'Berhasil delete data',
                "data" => $user,
            ], 200);
        }
        catch(\Exception $e){
            return response()->json([
                "status" => false,
                "message" => $e->getMessage(),
                "data" => []
            ], 400);
        }
    }

    public function login(Request $request){
        $creds = $request->only('username', 'password');

        if(Auth::attempt($creds)){
            return response()->json([
                'status' => true,
                'message' => 'Login berhasil',
                'data' => Auth::user(),
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Login gagal',
                'data' => [],
            ], 401);
        }
    }
}
