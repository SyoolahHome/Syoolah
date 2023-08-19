package com.tangem.tangem_sdk;

import java.lang.System;

/**
 * TangemSdkPlugin
 */
@kotlin.Metadata(mv = {1, 8, 0}, k = 1, d1 = {"\u0000\u0082\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010\u000e\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0002\b\u0006\n\u0002\u0018\u0002\n\u0002\b\t\u0018\u00002\u00020\u00012\u00020\u00022\u00020\u0003B\u0005\u00a2\u0006\u0002\u0010\u0004J\u0010\u0010\u0014\u001a\u00020\f2\u0006\u0010\u0015\u001a\u00020\u0016H\u0002J\u0018\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\u00132\u0006\u0010\u000b\u001a\u00020\fH\u0002J\u001c\u0010\u001a\u001a\u00020\u001b2\n\u0010\u001c\u001a\u00060\u001dj\u0002`\u001e2\u0006\u0010\u001f\u001a\u00020 H\u0002J\u0018\u0010!\u001a\u00020\u001b2\u0006\u0010\"\u001a\u00020#2\u0006\u0010$\u001a\u00020 H\u0002J\u0010\u0010%\u001a\u00020\u001b2\u0006\u0010\u0015\u001a\u00020\u0016H\u0016J\u0010\u0010&\u001a\u00020\u001b2\u0006\u0010\'\u001a\u00020(H\u0016J\b\u0010)\u001a\u00020\u001bH\u0016J\b\u0010*\u001a\u00020\u001bH\u0016J\u0010\u0010+\u001a\u00020\u001b2\u0006\u0010,\u001a\u00020(H\u0016J\u0018\u0010-\u001a\u00020\u001b2\u0006\u0010.\u001a\u00020/2\u0006\u0010\u001f\u001a\u00020 H\u0016J\u0010\u00100\u001a\u00020\u001b2\u0006\u0010\u0015\u001a\u00020\u0016H\u0016J\u0018\u00101\u001a\u00020\u001b2\u0006\u0010.\u001a\u00020/2\u0006\u0010\u001f\u001a\u00020 H\u0002J\u0018\u00102\u001a\u00020\u001b2\u0006\u0010.\u001a\u00020/2\u0006\u0010$\u001a\u00020 H\u0002J\"\u00103\u001a\u0002H4\"\u0006\b\u0000\u00104\u0018\u0001*\u00020/2\u0006\u00105\u001a\u00020#H\u0082\b\u00a2\u0006\u0002\u00106J$\u00107\u001a\u0004\u0018\u0001H4\"\u0006\b\u0000\u00104\u0018\u0001*\u00020/2\u0006\u00105\u001a\u00020#H\u0082\b\u00a2\u0006\u0002\u00106R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\fX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000f\u001a\u00020\u0010X\u0082.\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0011\u001a\b\u0012\u0004\u0012\u00020\u00130\u0012X\u0082.\u00a2\u0006\u0002\n\u0000\u00a8\u00068"}, d2 = {"Lcom/tangem/tangem_sdk/TangemSdkPlugin;", "Lio/flutter/embedding/engine/plugins/FlutterPlugin;", "Lio/flutter/plugin/common/MethodChannel$MethodCallHandler;", "Lio/flutter/embedding/engine/plugins/activity/ActivityAware;", "()V", "channel", "Lio/flutter/plugin/common/MethodChannel;", "converter", "Lcom/tangem/common/json/MoshiJsonConverter;", "handler", "Landroid/os/Handler;", "nfcManager", "Lcom/tangem/sdk/nfc/NfcManager;", "replyAlreadySubmit", "", "sdk", "Lcom/tangem/TangemSdk;", "wActivity", "Ljava/lang/ref/WeakReference;", "Landroid/app/Activity;", "createNfcManager", "pluginBinding", "Lio/flutter/embedding/engine/plugins/activity/ActivityPluginBinding;", "createViewDelegate", "Lcom/tangem/SessionViewDelegate;", "activity", "handleException", "", "ex", "Ljava/lang/Exception;", "Lkotlin/Exception;", "result", "Lio/flutter/plugin/common/MethodChannel$Result;", "handleResult", "methodResul", "", "callback", "onAttachedToActivity", "onAttachedToEngine", "flutterPluginBinding", "Lio/flutter/embedding/engine/plugins/FlutterPlugin$FlutterPluginBinding;", "onDetachedFromActivity", "onDetachedFromActivityForConfigChanges", "onDetachedFromEngine", "binding", "onMethodCall", "call", "Lio/flutter/plugin/common/MethodCall;", "onReattachedToActivityForConfigChanges", "runJSONRPCRequest", "setScanImage", "extract", "T", "name", "(Lio/flutter/plugin/common/MethodCall;Ljava/lang/String;)Ljava/lang/Object;", "extractOptional", "tangem_sdk_debug"})
public final class TangemSdkPlugin implements io.flutter.embedding.engine.plugins.FlutterPlugin, io.flutter.plugin.common.MethodChannel.MethodCallHandler, io.flutter.embedding.engine.plugins.activity.ActivityAware {
    private io.flutter.plugin.common.MethodChannel channel;
    private final android.os.Handler handler = null;
    private java.lang.ref.WeakReference<android.app.Activity> wActivity;
    private com.tangem.TangemSdk sdk;
    private com.tangem.sdk.nfc.NfcManager nfcManager;
    private final com.tangem.common.json.MoshiJsonConverter converter = null;
    private boolean replyAlreadySubmit = false;
    
    public TangemSdkPlugin() {
        super();
    }
    
    @java.lang.Override
    public void onAttachedToEngine(@org.jetbrains.annotations.NotNull
    io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
    }
    
    @java.lang.Override
    public void onDetachedFromEngine(@org.jetbrains.annotations.NotNull
    io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding binding) {
    }
    
    @java.lang.Override
    public void onAttachedToActivity(@org.jetbrains.annotations.NotNull
    io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding pluginBinding) {
    }
    
    @java.lang.Override
    public void onDetachedFromActivity() {
    }
    
    private final com.tangem.sdk.nfc.NfcManager createNfcManager(io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding pluginBinding) {
        return null;
    }
    
    private final com.tangem.SessionViewDelegate createViewDelegate(android.app.Activity activity, com.tangem.sdk.nfc.NfcManager nfcManager) {
        return null;
    }
    
    @java.lang.Override
    public void onReattachedToActivityForConfigChanges(@org.jetbrains.annotations.NotNull
    io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding pluginBinding) {
    }
    
    @java.lang.Override
    public void onDetachedFromActivityForConfigChanges() {
    }
    
    @java.lang.Override
    public void onMethodCall(@org.jetbrains.annotations.NotNull
    io.flutter.plugin.common.MethodCall call, @org.jetbrains.annotations.NotNull
    io.flutter.plugin.common.MethodChannel.Result result) {
    }
    
    private final void runJSONRPCRequest(io.flutter.plugin.common.MethodCall call, io.flutter.plugin.common.MethodChannel.Result result) {
    }
    
    /**
     * {
     *   "base64": "encodedBase64ImageSource",
     *   "verticalOffset": 0    // optional
     * }
     */
    private final void setScanImage(io.flutter.plugin.common.MethodCall call, io.flutter.plugin.common.MethodChannel.Result callback) {
    }
    
    private final void handleResult(java.lang.String methodResul, io.flutter.plugin.common.MethodChannel.Result callback) {
    }
    
    private final void handleException(java.lang.Exception ex, io.flutter.plugin.common.MethodChannel.Result result) {
    }
}