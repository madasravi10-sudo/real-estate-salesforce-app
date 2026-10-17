import { LightningElement, track } from 'lwc';

export default class TodoList extends LightningElement {
    tasks = [];
    newTask = '';

    handleInput(event) {
        this.newTask = event.target.value;
    }

    handleAdd() {
        if (this.newTask.trim()) {
            this.tasks = [...this.tasks, { id: Date.now(), name: this.newTask }];
            this.newTask = '';
        }
    }

    handleDelete(event) {
        const taskId = event.target.dataset.id;
        this.tasks = this.tasks.filter(task => task.id !== parseInt(taskId));
    }
}