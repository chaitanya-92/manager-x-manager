// IKsuInterface.aidl
package com.astrotalk.manager;

import android.content.pm.PackageInfo;
import rikka.parcelablelist.ParcelableListSlice;

interface IKsuInterface {
    ParcelableListSlice<PackageInfo> getPackages(int flags);
}