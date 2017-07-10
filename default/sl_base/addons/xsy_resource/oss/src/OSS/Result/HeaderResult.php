<?php
/**
 * @Author: 特筹网
 * @Date:   2016-08-12 16:56:23
 * @Last Modified by:   gangan
 * @Last Modified time: 2016-08-12 17:36:47
 */

namespace OSS\Result;


/**
 * Class HeaderResult
 * @package OSS\Result
 * @link https://docs.aliyun.com/?spm=5176.383663.13.7.HgUIqL#/pub/oss/api-reference/object&GetObjectMeta
 */
class HeaderResult extends Result
{
    /**
     * 把返回的ResponseCore中的header作为返回数据
     *
     * @return array
     */
    protected function parseDataFromResponse()
    {
        return empty($this->rawResponse->header) ? array() : $this->rawResponse->header;
    }

}