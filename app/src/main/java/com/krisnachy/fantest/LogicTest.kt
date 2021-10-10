package com.krisnachy.fantest

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

fun main() {
    val arr1 = arrayOf(10, 20, 20, 10, 10, 30, 50, 10, 20)
    val arr2 = arrayOf(6, 5, 2, 3, 5, 2, 2, 1, 1, 5, 1, 3, 3, 3, 5)
    val arr3 = arrayOf(1, 1, 3, 1, 2, 1, 3, 3, 3, 3)
    println("Jumlah Pasang yang Dapat Dijual")
    println("1. ${jumlahPasang(arr1)}")
    println("2. ${jumlahPasang(arr2)}")
    println("3. ${jumlahPasang(arr3)}")
}