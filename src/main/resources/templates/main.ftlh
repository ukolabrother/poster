<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>


<@c.page>
    <div>
        <@l.logout />
        <span><a href="/user">user list</a> </span>
    </div>
    <div>
        <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="text" name="text" placeholder="input post">
            <input type="text" name="tag" placeholder="tag">
            <input type="file" name="file">
            <button type="submit">add</button>
        </form>
        <form method="get" action="/main">
            <input type="text" name="filter" placeholder="search..." value="${filter?ifExists}">
            <button type="submit">search</button>
        </form>
    </div>
    <div>List of posts</div>
    <#list posts as post>
        <div>
            <b>${post.id}</b>
            <span>${post.text}</span>
            <i>${post.tag}</i>
            <strong>${post.authorName}</strong>
            <div>
                <#if post.filename??>
                    <img src="/img/${post.filename}"
                </#if>
            </div>
        </div>
    <#else>
        no posts
    </#list>
</@c.page>