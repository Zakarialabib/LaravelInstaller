<script>
  import { invoke } from "@tauri-apps/api/tauri";
  import { onMount } from "svelte";
  import { Command } from "@tauri-apps/api/shell";
  import { confirm } from "@tauri-apps/api/dialog";

  let log = [];
  let pid = null;
  let status = "";

  const windows = navigator.userAgent.includes("Windows");
  let cmd = windows ? "cmd" : "sh";

  const steps = [
    {
      name: "Check for Dependencies",
      description: "Check if necessary dependencies are installed",
      action: checkDependencies,
    },
    {
      name: "Install Dependencies",
      description: "Prompt user to install dependencies if missing",
      action: installDependencies,
    },
    {
      name: "Set up Laravel Project",
      description: "Set up Laravel project",
      action: setUpLaravel,
    },
    {
      name: "Configure Server",
      description: "Configure Apache, PHP, and PHPMyAdmin",
      action: configureServer,
    },
    {
      name: "Complete Installation",  
      description: "Run scripts or commands to complete Laravel installation",
      action: completeInstallation,
    },
    {
      name: "Provide Feedback",
      description: "Provide feedback and allow access to logs",
      action: provideFeedback,
    },
    {
      name: "Launch Laravel Project",
      description: "Launch Laravel project",
      action: launchProject,
    },
  ];

  let currentStep = 0;
  let stepData = null;

  onMount(async () => {
    await executeStep(currentStep);
  });

  /**
   * @param {number} stepIndex
   */
  async function executeStep(stepIndex) {
    if (stepIndex === steps.length) return;

    const step = steps[stepIndex];
    try {
      stepData = await step.action();
      currentStep++;
      status = `Step ${stepIndex + 1} succeeded`;
      console.log(`Step ${stepIndex + 1} succeeded:`, stepData);
    } catch (e) {
      console.error(`Step ${stepIndex + 1} failed:`, e);
      status = `Step ${stepIndex + 1} failed`;
      stepData = e.message;
    }
  }
  

  async function checkDependencies() {
    const result = new Command("check_dependencies", [
      "sh",
      "./src/scripts/check_dependencies.sh",
    ]);
    result.stdout.on("data", (line) => {
      if (line) {
        log = [...log, line];
      }
    });
      const child = await result.spawn();
      pid = child.pid;
      console.log(log);
  }

  async function installDependencies() {
    const result = await confirm(
      "Some dependencies are missing, do you want to install them now?",
      { title: "Confirmation", type: "warning" }
    );

    if (result) {
      const result = new Command("install_dependencies", [
        "sh",
        "./src/scripts/install_dependencies.sh",
      ]);
      result.stdout.on("data", (line) => {
      if (line) {
        log = [...log, line];
      }
    });
      const child = await result.spawn();
      pid = child.pid;
      console.log(log);
    }
  }

  async function setUpLaravel() {
    const result = new Command("set_up_laravel", [
      "sh",
      "./src/scripts/set_up_laravel.sh",
    ]);
     result.stdout.on("data", (line) => {
      if (line) {
        log = [...log, line];
      }
    });
      const child = await result.spawn();
      pid = child.pid;
      console.log(log);
  }

  async function configureServer() {
    const result = new Command("configure_server", [
      "sh",
      "./src/scripts/configure_server.sh",
    ]);
     result.stdout.on("data", (line) => {
      if (line) {
        log = [...log, line];
      }
    });
      const child = await result.spawn();
      pid = child.pid;
      console.log(log);
  }

  async function completeInstallation() {
    const result = new Command("complete_installation", [
      "sh",
      "./src/scripts/complete_installation.sh",
    ]);
     result.stdout.on("data", (line) => {
      if (line) {
        log = [...log, line];
      }
    });
      const child = await result.spawn();
      pid = child.pid;
      console.log(log);
  }

  async function provideFeedback() {
    const result = await confirm(
      "The Laravel project has been successfully installed. View logs?",
      { title: "Installation Complete" }
    );
    if (result) {
      console.log(log);
    }
  }

  async function launchProject() {
    const result = new Command("launch_project", [
      "sh",
      "./src/scripts/launch_project.sh",
    ]);
    const output = await result.execute();
     result.stdout.on("data", (line) => {
      if (line) {
        log = [...log, line];
      }
    });
    const child = await result.spawn();
    pid = child.pid;
    console.log(log);
  }
  $: progress = (currentStep / steps.length) * 100;

  
</script>

<main>
  <div class="container">
    <p>Step {currentStep + 1} of {steps.length}: {steps[currentStep].name}</p>
    <p>{steps[currentStep].description}</p>
    <div class="progress-bar">
      <div class="progress-bar-fill" style="width: {progress}%" />
    </div>
  
        

    {#if stepData !== null}
        <p>
        Pid: {pid} <br>
        <code>{log.join("\n")}</code>
        </p>
      <p
        class={stepData === true
          ? "status-success"
          : stepData === false
          ? "status-cancelled"
          : "status-error"}
      >
        Status: { status }
        {#if stepData === true} Success! {/if}
        {#if stepData === false} Cancelled. {/if}
        {#if typeof stepData === "string"} Error: {stepData}. {/if}
      </p>
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
  .progress-bar {
    width: 100%;
    height: 1em;
    background-color: lightgray;
    border-radius: 0.5em;
    overflow: hidden;
  }

  .progress-bar-fill {
    height: 100%;
    background-color: blue;
  }
  .status-success {
    color: green;
  }
  .status-cancelled {
    color: red;
  }
  .status-error {
    color: orange;
  }
</style>
