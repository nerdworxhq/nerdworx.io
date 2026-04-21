<script setup lang="ts">
import { Head } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Home">
        <link rel="preconnect" href="https://rsms.me/" />
        <link rel="stylesheet" href="https://rsms.me/inter/inter.css" />
    </Head>
    <div class="flex min-h-screen items-center justify-center bg-gray-100 text-[#1b1b18] dark:bg-gray-800 dark:text-[#EDEDEC] px-2">
        <div class="flex flex-col items-center w-full max-w-4xl">
            <div class="grid grid-cols-2 lg:flex lg:gap-2 gap-1 mb-4 lg:mb-8 -mt-[40vh] lg:-mt-[50vh] w-full lg:w-auto">
                <a href="/services" class="w-full lg:w-[200px] h-[300px] lg:h-[900px] bg-teal-700 flex flex-col items-center justify-end pb-2 lg:pb-4 border-2 lg:border-4 border-transparent hover:border-teal-900 hover:bg-teal-800 transition-all duration-300 hover:scale-105 active:scale-95">
                    <h3 class="text-lg lg:text-2xl font-medium text-white">Services</h3>
                    <p class="text-xs lg:text-sm text-white/80 mt-1 text-center px-2">What we nerd about</p>
                </a>
                <div class="w-full lg:w-[200px] h-[300px] lg:h-[900px] bg-white flex flex-col items-center justify-end pb-2 lg:pb-4 border-2 lg:border-4 border-transparent hover:border-gray-300 hover:bg-gray-100 transition-all duration-300 hover:scale-105 active:scale-95 group">
                    <div class="flex-1 flex flex-col items-center justify-center space-y-2 lg:space-y-4 px-2">
                        <!-- Pwn Me Not -->
                        <a href="https://pwnmenot.io" class="flex flex-col items-center p-2 lg:p-3 rounded-lg hover:bg-gray-200 transition-colors duration-200 w-full">
                            <div class="w-8 h-8 lg:w-12 lg:h-12 mb-1 lg:mb-2 bg-blue-600 rounded-lg flex items-center justify-center">
                                <svg class="w-4 h-4 lg:w-6 lg:h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                            </div>
                            <span class="text-xs lg:text-sm font-medium text-black text-center">Pwn Me Not</span>
                        </a>
                        
                        <!-- ResolveBot -->
                        <a href="https://resolvebot.io" class="flex flex-col items-center p-2 lg:p-3 rounded-lg hover:bg-gray-200 transition-colors duration-200 w-full">
                            <div class="w-8 h-8 lg:w-12 lg:h-12 mb-1 lg:mb-2 bg-green-600 rounded-lg flex items-center justify-center">
                                <svg class="w-4 h-4 lg:w-6 lg:h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 15l-2 5L9 9l11 4-5 2zm0 0l5 5M7.188 2.239l.777 2.897M5.136 7.965l-2.898-.777M13.95 4.05l-2.122 2.122m-5.657 5.656l-2.12 2.122"/>
                                </svg>
                            </div>
                            <span class="text-xs lg:text-sm font-medium text-black text-center">ResolveBot</span>
                        </a>
                    </div>
                    
                    <div class="mt-2 text-center">
                        <a href="/products">
                            <h3 class="text-lg lg:text-2xl font-medium text-black">Products</h3>
                            <p class="text-xs lg:text-sm text-black/80 mt-1 text-center px-2">Larger nerd moments</p>
                        </a>
                    </div>
                </div>
                <a href="/projects" class="w-full lg:w-[200px] h-[300px] lg:h-[900px] bg-blue-800 flex flex-col items-center justify-end pb-2 lg:pb-4 border-2 lg:border-4 border-transparent hover:border-blue-900 hover:bg-blue-900 transition-all duration-300 hover:scale-105 active:scale-95">
                    <h3 class="text-lg lg:text-2xl font-medium text-white">Projects</h3>
                    <p class="text-xs lg:text-sm text-white/80 mt-1 text-center px-2">Smaller nerd moments</p>
                </a>
                <a href="/contact" class="w-full lg:w-[200px] h-[300px] lg:h-[900px] bg-green-700 flex flex-col items-center justify-end pb-2 lg:pb-4 border-2 lg:border-4 border-transparent hover:border-green-900 hover:bg-green-800 transition-all duration-300 hover:scale-105 active:scale-95">
                    <h3 class="text-lg lg:text-2xl font-medium text-white">Reach out</h3>
                    <p class="text-xs lg:text-sm text-white/80 mt-1 text-center px-2">Nerd with us</p>
                </a>
                <a href="/docs" class="w-full lg:w-[200px] h-[300px] lg:h-[900px] bg-red-800 flex flex-col items-center justify-end pb-2 lg:pb-4 border-2 lg:border-4 border-transparent hover:border-red-900 hover:bg-red-900 transition-all duration-300 hover:scale-105 active:scale-95">
                    <h3 class="text-lg lg:text-2xl font-medium text-white">Tech docs</h3>
                    <p class="text-xs lg:text-sm text-white/80 mt-1 text-center px-2">All about the details</p>
                </a>
            </div>
            <h1 class="text-2xl lg:text-4xl font-medium">nerdworx</h1>
        </div>
        <div class="fixed bottom-0 left-0 right-0 p-2 lg:p-4 text-center text-xs lg:text-sm text-gray-600 dark:text-gray-400">
            Nerdworx LLC, Nashville, TN 37208
            615-879-6012
        </div>
    </div>
</template>