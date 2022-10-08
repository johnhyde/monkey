<script lang="ts">
  import { push, replace, location, querystring } from 'svelte-spa-router';
  import pageName from 'stores/pageName';
  import { buildQuerystring } from 'lib/utils';
  export let params: any = {};
</script>

<div class="bg-white p-4 space-y-4 min-h-full flex flex-col items-center 2xs:p-8 2xs:space-y-8">
  Welcome to Monke
</div>
