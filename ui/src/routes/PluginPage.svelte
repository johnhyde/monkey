<script lang="ts">
  import { push, replace, location, querystring } from 'svelte-spa-router';
  import pageName from 'stores/pageName';
  import { buildQuerystring } from 'lib/utils';
  import patch from 'actions/patch';
  export let params: any = {};
  
  function updateTitle({ detail: title }) {
    $pageName = title;
  }
</script>

{#key params.app}
  <iframe src="/apps/{params.app}" title="params.app" class="w-full h-full"
    use:patch={{ app: params.app}}
    on:titleChanged={updateTitle}
  />
{/key}
