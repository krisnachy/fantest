package com.krisnachy.fantest

import java.util.regex.Matcher
import java.util.regex.Pattern

fun jumlahPasang(array: Array<Int>): Int {
    val filter = array.groupingBy { it }.eachCount().filter { it.value > 1 }.map { it.value }
    var ganjil = 0
    var genap = 0
    for (i in filter) {
        if (i % 2 != 0) {
            ganjil = ganjil + (i - 1)
        } else {
            genap += i
        }
    }
    val hasil = (ganjil + genap) / 2
    return hasil
}

fun jumlahKata(kata: String): Int {
    var counter = 0
    val pattern: Pattern = Pattern.compile("[a-zA-Z]+[^A-Za-z]*")
    var string = ""

    string = kata.replace("-", "")
    val words = string.split(" ").toTypedArray()
    for (word in words) {
        val matcher: Matcher = pattern.matcher(word)
        if (matcher.matches()) {
            counter++
        }
    }

    return counter
}

fun main() {
    val arr1 = arrayOf(10, 20, 20, 10, 10, 30, 50, 10, 20)
    val arr2 = arrayOf(6, 5, 2, 3, 5, 2, 2, 1, 1, 5, 1, 3, 3, 3, 5)
    val arr3 = arrayOf(1, 1, 3, 1, 2, 1, 3, 3, 3, 3)
    println("Jumlah Pasang yang Dapat Dijual")
    println("1. ${jumlahPasang(arr1)}")
    println("2. ${jumlahPasang(arr2)}")
    println("3. ${jumlahPasang(arr3)}")

    val kata1 = jumlahKata("Saat meng*ecat tembok, Agung dib_antu oleh Raihan.")
    val kata2 = jumlahKata("Berapa u(mur minimal[ untuk !mengurus ktp?")
    val kata3 = jumlahKata("Masing-masing anak mendap(atkan uang jajan ya=ng be&rbeda.")
    println("Menghitung Jumlah Kata pada Kalimat")
    println("1. " + kata1)
    println("2. " + kata2)
    println("3. " + kata3)
}