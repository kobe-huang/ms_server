<?php
/**
 * @Author: 特筹网
 * @Date:   2016-08-12 16:56:23
 * @Last Modified by:   gangan
 * @Last Modified time: 2016-08-12 17:37:14
 */

namespace OSS\Result;

use OSS\Core\OssException;

/**
 * Class UploadPartResult
 * @package OSS\Result
 */
class UploadPartResult extends Result
{
    /**
     * 结果中part的ETag
     *
     * @return string
     * @throws OssException
     */
    protected function parseDataFromResponse()
    {
        $header = $this->rawResponse->header;
        if (isset($header["etag"])) {
            return $header["etag"];
        }
        throw new OssException("cannot get ETag");

    }
}