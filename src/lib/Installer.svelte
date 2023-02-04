<script>
    import { invoke } from "@tauri-apps/api/tauri";
    import { onMount } from 'svelte';
    import { Command } from '@tauri-apps/api/shell';
    import { confirm } from "@tauri-apps/api/dialog";

    let log = '';

    const windows = navigator.userAgent.includes('Windows')
    let cmd = windows ? 'cmd' : 'sh'

    const steps = [
      {
        name: 'Check for Dependencies',
        description: 'Check if necessary dependencies are installed',
        action: checkDependencies
      },
      {
        name: 'Install Dependencies',
        description: 'Prompt user to install dependencies if missing',
        action: installDependencies
      },
      {
        name: 'Set up Laravel Project',
        description: 'Set up Laravel project',
        action: setUpLaravel
      },
      {
        name: 'Configure Server',
        description: 'Configure Apache, PHP, and PHPMyAdmin',
        action: configureServer
      },
      {
        name: 'Complete Installation',
        description: 'Run scripts or commands to complete Laravel installation',
        action: completeInstallation
      },
      {
        name: 'Provide Feedback',
        description: 'Provide feedback and allow access to logs',
        action: provideFeedback
      },
      {
        name: 'Launch Laravel Project',
        description: 'Launch Laravel project',
        action: launchProject
      }
    ];

    let currentStep = 0;
    let stepData = null;

    onMount(async () => {
      await executeStep(currentStep);
    });

    async function executeStep(stepIndex) {
      if (stepIndex === steps.length) return;

      const step = steps[stepIndex];
      try {
        stepData = await step.action();
        currentStep++;
        console.log(`Step ${stepIndex + 1} succeeded:`, stepData);
      } catch (e) {
        console.error(`Step ${stepIndex + 1} failed:`, e);
        stepData = e.message;
      }
    }

    async function checkDependencies() {


      const result = new Command('run-git-commit', ['commit', '-m', 'the commit message']);
      
      result.code === 0;
      result.signal === null;
      log = result.stdout;
      console.log(log);
      
    }

    async function installDependencies() {
      const result = await confirm('Some dependencies are missing, do you want to install them now?', { title: 'Confirmation', type: 'warning' });

      if (result) {
        const result = new Command('install_dependencies');
        const output = await result.execute();
        log = output.stdout;
        console.log(log);
      }
    }

    async function setUpLaravel() {
      const result = new Command('set_up_laravel');
      const output = await result.execute();
      log = output.stdout;
      console.log(log);
    }

    async function configureServer() {
      const result = new Command('configure_server');
      const output = await result.execute();
      log = output.stdout;
      console.log(log);
    }

    async function completeInstallation() {
      const result = new Command('complete_installation');
      const output = await result.execute();
      log = output.stdout;
      console.log(log);
    }
  
    async function provideFeedback() {
      const result = await confirm('The Laravel project has been successfully installed. View logs?', { title: 'Installation Complete' });
      if (result) {
        console.log(log);
      }
    }
  
    async function launchProject() {
      const result = new Command('launch_project');
      const output = await result.execute();
      log = output.stdout;
      
    }
</script>
    
  
<main>
  <div class="container">
    <p>Step {currentStep + 1} of {steps.length}: {steps[currentStep].name}</p>
    <p>{steps[currentStep].description}</p>
    {#if stepData !== null}
    <p>Status: {#if stepData === true} Success! {/if}{#if stepData === false} Cancelled. {/if}{#if typeof stepData === 'string'} Error: {stepData}. {/if}</p>
    <button on:click={() => executeStep(currentStep + 1)}>Next</button>
  {/if}
  </div>
</main>
  
  <style>
    main {
      padding: 1em;
    }
  
    button {
      background-color: blue;
      color: white;
      border: none;
      padding: 0.5em 1em;
      border-radius: 0.5em;
      cursor: pointer;
    }
  </style>

  