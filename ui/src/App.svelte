<script lang="ts">
  import Router from 'svelte-spa-router';
  import PluginPage from './routes/PluginPage.svelte';
  import Home from './routes/Home.svelte';
  import "./styles/styles.scss";

  const routes = {
    '/:app': PluginPage,
    '*': Home,
  }


  import pageName from './stores/pageName';

  $: title = $pageName || 'Monkey';

  $: {
    document.title = title
  }
</script>

<main class="h-full">
  <Router {routes} />
</main>

<svelte:head>
  <title>{title}</title>
</svelte:head>