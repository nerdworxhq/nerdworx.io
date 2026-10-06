<script setup lang="ts">
import { Head } from '@inertiajs/vue3';

// Set by CI to the build tag (e.g. 2026.10.06.153012-main); local builds show "dev".
const version = import.meta.env.VITE_APP_VERSION || 'dev';
</script>

<template>
    <Head title="Welcome">
        <link rel="preconnect" href="https://rsms.me/" />
        <link rel="stylesheet" href="https://rsms.me/inter/inter.css" />
    </Head>
    <div
        class="flex min-h-screen flex-col justify-end bg-[#FDFDFC] p-6 text-[#1b1b18] dark:bg-[#0a0a0a] dark:text-[#EDEDEC]"
    >
        <footer class="text-center text-sm">
            <p class="font-medium">nerdworx.io</p>
            <p class="text-xs text-[#706f6c] dark:text-[#A1A09A]">
                v{{ version }}
            </p>
        </footer>
    </div>
</template>
