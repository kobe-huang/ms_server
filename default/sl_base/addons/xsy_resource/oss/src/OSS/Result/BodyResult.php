<?php
/**
 * @Author: 特筹网
 * @Date:   2016-08-12 16:56:23
 * @Last Modified by:   gangan
 * @Last Modified time: 2016-08-12 17:36:24
 */

namespace OSS\Result;


/**
 * Class BodyResult
 * @package OSS\Result
 */
class BodyResult extends Result
{
    /**
     * @return string
     */
    protected function parseDataFromResponse()
    {
        return empty($this->rawResponse->body) ? "" : $this->rawResponse->body;
    }
}