require 'rails_helper'

RSpec.describe 'Task', type: :system do
  let(:project) { create(:project) }
  let(:task) { create(:task) }

  describe 'Task一覧' do
    context '正常系' do
      it '一覧ページにアクセスした場合、Taskが表示されること' do
        # TODO: ローカル変数ではなく let を使用してください
        visit project_tasks_path(task.project)
        expect(find('.task_list')).to have_content task.title
        expect(Task.count).to eq 1
        expect(current_path).to eq project_tasks_path(task.project)
      end

      it 'Project詳細からTask一覧ページにアクセスした場合、Taskが表示されること' do
        # FIXME: テストが失敗するので修正してください
        visit project_path(task.project)
        click_link 'View Todos'
        switch_to_window(windows.last)
        expect(find('.task_list')).to have_content task.title
        expect(Task.count).to eq 1
        expect(current_path).to eq project_tasks_path(task.project)
      end
    end
  end

  describe 'Task新規作成' do
    context '正常系' do
      it 'Taskが新規作成されること' do
        # TODO: ローカル変数ではなく let を使用してください
        visit project_tasks_path(project)
        click_link 'New Task'
        fill_in 'Title', with: 'create'
        click_button 'Create Task'
        expect(page).to have_content('Task was successfully created.')
        expect(Task.count).to eq 1
        expect(current_path).to eq '/projects/1/tasks/1'
      end
    end
  end

  describe 'Task詳細' do
    context '正常系' do
      it 'Taskが表示されること' do
        # TODO: ローカル変数ではなく let を使用してください
        visit project_task_path(task.project, task)
        expect(page).to have_content(task.title)
        expect(page).to have_content(task.status)
        expect(page).to have_content(task.deadline.strftime('%Y-%m-%d %H:%M'))
        expect(current_path).to eq project_task_path(task.project, task)
      end
    end
  end

  describe 'Task編集' do
    context '正常系' do
      let(:completed_task) { create(:task, :done) }

      it 'Taskを編集した場合、一覧画面で編集後の内容が表示されること' do
        # FIXME: テストが失敗するので修正してください
        visit edit_project_task_path(task.project, task)
        fill_in 'Deadline', with: Time.current
        click_button 'Update Task'
        click_link 'Back'
        expect(find('.task_list')).to have_content(short_time(Time.current))
        expect(current_path).to eq project_tasks_path(task.project)
      end

      it 'ステータスを完了にした場合、Taskの完了日に今日の日付が登録されること' do
        # TODO: ローカル変数ではなく let を使用してください
        visit edit_project_task_path(task.project, task)
        select 'done', from: 'Status'
        click_button 'Update Task'
        expect(page).to have_content('done')
        expect(page).to have_content(Time.current.strftime('%Y-%m-%d'))
        expect(current_path).to eq project_task_path(task.project, task)
      end

      it '既にステータスが完了のタスクのステータスを変更した場合、Taskの完了日が更新されないこと' do
        # TODO: FactoryBotのtraitを利用してください
        visit edit_project_task_path(completed_task.project, completed_task)
        select 'todo', from: 'Status'
        click_button 'Update Task'
        expect(page).to have_content('todo')
        expect(page).not_to have_content(Time.current.strftime('%Y-%m-%d'))
        expect(current_path).to eq project_task_path(completed_task.project, completed_task)     
      end
    end
  end

  describe 'Task削除' do
    context '正常系' do
      # FIXME: テストが失敗するので修正してください
      it 'Taskが削除されること' do       
        visit project_tasks_path(task.project)
        click_link 'Destroy'
        page.driver.browser.switch_to.alert.accept
        expect(find('.task_list')).not_to have_content task.title        
        expect(current_path).to eq project_tasks_path(task.project)
      end
    end
  end
end
