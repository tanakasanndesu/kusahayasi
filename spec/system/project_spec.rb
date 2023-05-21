require 'rails_helper'

RSpec.describe 'Project', type: :system do
  let(:project) { create(:project) }

  describe 'Project一覧' do
    context '正常系' do
      it 'Projectが表示されること' do
        project
        visit projects_path
        expect(page).to have_content 'Projects'
        expect(page).to have_content project.name
        expect(page).to have_content project.status
        expect(page).to have_content project.release_date
        expect(Project.count).to eq 1
        expect(current_path).to eq projects_path
      end
    end
  end

  describe 'Project新規作成' do
    context '正常系' do
      it 'Projectが新規作成されること' do
        visit projects_path
        click_on 'New Project'
        fill_in 'Name', with: 'create'
        select 'doing', from: 'Status'
        fill_in 'Release date', with: Date.new(2019, 01, 01)
        click_on 'Create Project'
        expect(page).to have_content 'Project was successfully created'
        expect(page).to have_content 'create'
        expect(page).to have_content 'doing'
        expect(page).to have_content Date.new(2019, 01, 01)
        expect(Project.count).to eq 1
        expect(current_path).to eq '/projects/1'
      end
    end

    context '異常系' do
      it 'Nameが未入力の場合、Projectが新規作成されないこと' do
        visit projects_path
        click_on 'New Project'
        fill_in 'Name', with: ''
        select 'doing', from: 'Status'
        fill_in 'Release date', with: Date.new(2019, 01, 01)
        click_on 'Create Project'
        expect(page).to have_content '1 error prohibited this project from being saved:'
        expect(page).to have_content "Name can't be blank"
        expect(Project.count).to eq 0
        expect(current_path).to eq projects_path
      end
    end
  end

  describe 'Project詳細' do
    context '正常系' do
      it 'Projectが表示されること' do
        visit project_path(project)
        expect(page).to have_content project.name
        expect(page).to have_content project.status
        expect(page).to have_content project.release_date
        expect(Project.count).to eq 1
        expect(current_path).to eq project_path(project)
      end
    end
  end

  describe 'Project編集' do
    context '正常系' do
      it 'Projectが編集されること' do
        project
        visit projects_path
        click_on 'Edit'
        fill_in 'Name', with: 'edit'
        select 'done', from: 'Status'
        fill_in 'Release date', with: Date.new(2019, 12, 01)
        click_on 'Update Project'
        expect(page).to have_content 'Project was successfully updated'
        expect(page).to have_content 'edit'
        expect(page).to have_content 'done'
        expect(page).to have_content Date.new(2019, 12, 01)
        expect(Project.count).to eq 1
        expect(current_path).to eq project_path(project)
      end
    end

    context '異常系' do
      it 'Nameが未入力の場合、Projectが編集されないこと' do
        project
        visit projects_path
        click_on 'Edit'
        fill_in 'Name', with: ''
        select 'done', from: 'Status'
        fill_in 'Release date', with: Date.new(2019, 12, 01)
        click_on 'Update Project'
        expect(page).to have_content '1 error prohibited this project from being saved:'
        expect(page).to have_content "Name can't be blank"
        expect(Project.count).to eq 1
        expect(current_path).to eq project_path(project)
      end
    end
  end

  describe 'Project削除' do
    context '正常系' do
      it 'Projectが削除されること' do
        project
        visit projects_path
        click_on 'Destroy'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'Project was successfully destroyed'
        expect(page).not_to have_content project.name
        expect(page).not_to have_content project.status
        expect(page).not_to have_content project.release_date
        expect(Project.count).to eq 0
        expect(current_path).to eq projects_path
      end
    end
  end
end
