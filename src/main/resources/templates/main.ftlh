<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="form-row">
        <form method="get" action="/main" class="form-inline">
            <input type="text" name="filter" class="form-control" placeholder="search by tag"
                   value="${filter?ifExists}">
            <button type="submit" class="btn btn-primary ml-2">search</button>
        </form>
    </div>
    <a class="btn btn-primary mt-3" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false"
       aria-controls="collapseExample">
        add new post
    </a>
    <div class="collapse" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div class="form-group">
                    <input type="text" class="form-control" name="text" placeholder="input post">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="tag" placeholder="tag">
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" name="file" class="customFile">
                        <label class="custom-file-label" for="customFile">choose file</label>
                    </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">add</button>
                </div>
            </form>
        </div>
    </div>
    <div class="card-columns">
        <#list posts as post>
            <div class="card my-3">
                <div>
                    <#if post.filename??>
                        <img src="/img/${post.filename}" class="card-img-top">
                    </#if>
                </div>
                <div class="m-2">
                    <span>${post.text}</span>
                    <i>${post.tag}</i>
                </div>
                <div class="card-footer text-muted">
                    ${post.authorName}
                </div>
            </div>
        <#else>
            no posts
        </#list>
    </div>
</@c.page>