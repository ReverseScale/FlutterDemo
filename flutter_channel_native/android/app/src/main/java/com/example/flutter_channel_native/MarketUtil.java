package com.example.flutter_channel_native;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;

public class MarketUtil {
    private static final String TAG = "MarketUtil";

    /**
     * 跳转应用商店.
     *
     * @param context   {@link Context}
     * @param appPkg    包名
     * @param marketPkg 应用商店包名
     * @return {@code true} 跳转成功 <br> {@code false} 跳转失败
     */
    public static boolean toMarket(Context context, String appPkg, String marketPkg) {
        Uri uri = Uri.parse("market://details?id=" + appPkg);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        if (marketPkg != null) {// 如果没给市场的包名，则系统会弹出市场的列表让你进行选择。
            intent.setPackage(marketPkg);
        }
        try {
            context.startActivity(intent);
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * 启动到app详情界面
     * @param appPkg    App的包名
     * @param marketPkg 应用商店包名 ,如果为""则由系统弹出应用商店列表供用户选择,否则调转到目标市场的应用详情界面，某些应用商店可能会失败
     */
    public static void launchAppDetail(String appPkg, String marketPkg,Context context) {
        try {
            if (TextUtils.isEmpty(appPkg))
                return;

            Uri uri = Uri.parse("market://details?id=" + appPkg);
            Intent intent = new Intent(Intent.ACTION_VIEW, uri);
            if (!TextUtils.isEmpty(marketPkg))
                intent.setPackage(marketPkg);

            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 直接跳转至应用宝
     *
     * @param context {@link Context}
     * @param appPkg  包名
     * @return {@code true} 跳转成功 <br> {@code false} 跳转失败
     */
    public static boolean toQQDownload(Context context, String appPkg) {
        return toMarket(context, appPkg, "com.tencent.android.qqdownloader");
    }

    /**
     * 直接跳转至360手机助手
     *
     * @param context {@link Context}
     * @param appPkg  包名
     * @return {@code true} 跳转成功 <br> {@code false} 跳转失败
     */
    public static boolean to360Download(Context context, String appPkg) {
        return toMarket(context, appPkg, "com.qihoo.appstore");
    }

    /**
     * 直接跳转至豌豆荚
     *
     * @param context {@link Context}
     * @param appPkg  包名
     * @return {@code true} 跳转成功 <br> {@code false} 跳转失败
     */
    public static boolean toWandoujia(Context context, String appPkg) {
        return toMarket(context, appPkg, "com.wandoujia.phoenix2");
    }

    /**
     * 直接跳转至小米应用商店
     *
     * @param context {@link Context}
     * @param appPkg  包名
     * @return {@code true} 跳转成功 <br> {@code false} 跳转失败
     */
    public static boolean toXiaoMi(Context context, String appPkg) {
        return toMarket(context, appPkg, "com.xiaomi.market");
    }

    /**
     * 直接跳转至魅族应用商店
     *
     * @param context {@link Context}
     * @param appPkg  包名
     * @return {@code true} 跳转成功 <br> {@code false} 跳转失败
     */
    public static boolean toMeizu(Context context, String appPkg) {
        return toMarket(context, appPkg, "com.meizu.mstore");
    }

    /**
     * 跳转三星应用商店
     *
     * @param context     {@link Context}
     * @param packageName 包名
     * @return {@code true} 跳转成功 <br> {@code false} 跳转失败
     */
    public static boolean goToSamsungMarket(Context context, String packageName) {
        Uri uri = Uri.parse("http://www.samsungapps.com/appquery/appDetail.as?appId=" + packageName);
//        Uri uri = Uri.parse("http://apps.samsung.com/appquery/appDetail.as?appId=" + packageName);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        intent.setPackage("com.sec.android.app.samsungapps");
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        try {
            context.startActivity(intent);
            return true;
        } catch (ActivityNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 跳转索尼精选
     *
     * @param context {@link Context}
     * @param appId   索尼精选中分配得appId
     * @return {@code true} 跳转成功 <br> {@code false} 跳转失败
     */
    public static boolean goToSonyMarket(Context context, String appId) {
        Uri uri = Uri.parse("http://m.sonyselect.cn/" + appId);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
//        Intent intent = new Intent();
//        intent.setAction("com.sonymobile.playnowchina.android.action.NOTIFICATION_APP_DETAIL_PAGE");
//        intent.setAction("com.sonymobile.playnowchina.android.action.APP_DETAIL_PAGE");
//        intent.putExtra("app_id", 9115);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        try {
            context.startActivity(intent);
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * 检查已安装的应用商店
     * TODO 小米商店目前检测不出
     *
     * @param context {@link Context}
     * @return 返回包名列表
     */
    public static List<String> checkMarket(Context context) {
        List<String> packageNames = new ArrayList<>();
        Intent intent = new Intent();
        intent.setAction("android.intent.action.MAIN");
        intent.addCategory("android.intent.category.APP_MARKET");
        PackageManager pm = context.getPackageManager();
        List<ResolveInfo> infos = pm.queryIntentActivities(intent, 0);
        int size = infos.size();
        for (int i = 0; i < size; i++) {
            ActivityInfo activityInfo = infos.get(i).activityInfo;
            String packageName = activityInfo.packageName;
            Log.d(TAG, "packageName : " + packageName);
            packageNames.add(packageName);
        }
        return packageNames;
    }

    /**
     * 获取已安装应用商店的包名列表
     * @param context
     * @return
     */
    public static ArrayList<String> queryInstalledMarketPkgs(Context context) {
        ArrayList<String> pkgs = new ArrayList<String>();
        if (context == null)
            return pkgs;

        Intent intent = new Intent();
        intent.setAction("android.intent.action.MAIN");
        intent.addCategory("android.intent.category.APP_MARKET");
        PackageManager pm = context.getPackageManager();
        List<ResolveInfo> infos = pm.queryIntentActivities(intent, 0);
        if (infos == null || infos.size() == 0)
            return pkgs;

        int size = infos.size();
        for (int i = 0; i < size; i++) {
            String pkgName = "";
            try {
                ActivityInfo activityInfo = infos.get(i).activityInfo;
                pkgName = activityInfo.packageName;
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (!TextUtils.isEmpty(pkgName))
                pkgs.add(pkgName);
        }
        return pkgs;
    }



    /**

     * 过滤出已经安装的包名集合
     * @param context
     * @param pkgs
     *            待过滤包名集合
     * @return 已安装的包名集合
     */
    public static ArrayList<String> filterInstalledPkgs(Context context, ArrayList<String> pkgs) {
        ArrayList<String> empty = new ArrayList<String>();
        if (context == null || pkgs == null || pkgs.size() == 0)
            return empty;

        PackageManager pm = context.getPackageManager();
        List<PackageInfo> installedPkgs = pm.getInstalledPackages(0);
        int li = installedPkgs.size();
        int lj = pkgs.size();
        for (int j = 0; j < lj; j++) {
            for (int i = 0; i < li; i++) {
                String installPkg = "";
                String checkPkg = pkgs.get(j);
                try {
                    installPkg = installedPkgs.get(i).applicationInfo.packageName;
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (TextUtils.isEmpty(installPkg))
                    continue;

                if (installPkg.equals(checkPkg)) {
                    empty.add(installPkg);
                    break;
                }
            }
        }
        return empty;
    }
}
