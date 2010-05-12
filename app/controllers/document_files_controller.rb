class DocumentFilesController < ApplicationController
  # GET /document_files
  # GET /document_files.xml
  def index
    @document_files = DocumentFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @document_files }
    end
  end

  # GET /document_files/1
  # GET /document_files/1.xml
  def show
    @document_file = DocumentFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document_file }
    end
  end

  # GET /document_files/new
  # GET /document_files/new.xml
  def new
    @document_file = DocumentFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document_file }
    end
  end

  # GET /document_files/1/edit
  def edit
    @document_file = DocumentFile.find(params[:id])
  end

  # POST /document_files
  # POST /document_files.xml
  def create
    @document_file = DocumentFile.new(params[:document_file])

    respond_to do |format|
      if @document_file.save
        flash[:notice] = 'DocumentFile was successfully created.'
        format.html { redirect_to(@document_file) }
        format.xml  { render :xml => @document_file, :status => :created, :location => @document_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /document_files/1
  # PUT /document_files/1.xml
  def update
    @document_file = DocumentFile.find(params[:id])

    respond_to do |format|
      if @document_file.update_attributes(params[:document_file])
        flash[:notice] = 'DocumentFile was successfully updated.'
        format.html { redirect_to(@document_file) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /document_files/1
  # DELETE /document_files/1.xml
  def destroy
    @document_file = DocumentFile.find(params[:id])
    @document_file.destroy

    respond_to do |format|
      format.html { redirect_to(document_files_url) }
      format.xml  { head :ok }
    end
  end
end
