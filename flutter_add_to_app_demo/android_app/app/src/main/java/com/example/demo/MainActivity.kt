package com.example.demo

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import io.flutter.facade.Flutter
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        bottomNavigationView.setOnNavigationItemSelectedListener { item ->
            val index = when (item.itemId) {
                R.id.navigation_home -> 0
                R.id.navigation_dashboard -> 1
                R.id.navigation_notifications -> 2
                else -> throw RuntimeException("Unknown item ID ${item.itemId}")
            }

            viewPager.setCurrentItem(index, false)

            return@setOnNavigationItemSelectedListener true
        }

        viewPager.adapter = ViewPagerAdapter(supportFragmentManager, listOf(
            Flutter.createFragment("route1"),
            Fragment(),
            Fragment()
        ))
    }
}

private class ViewPagerAdapter(fm: androidx.fragment.app.FragmentManager?, val fragments: List<Fragment>) : androidx.fragment.app.FragmentPagerAdapter(fm) {
    override fun getCount(): Int {
        return fragments.count()
    }

    override fun getItem(position: Int): Fragment {
        return fragments[position]
    }
}
