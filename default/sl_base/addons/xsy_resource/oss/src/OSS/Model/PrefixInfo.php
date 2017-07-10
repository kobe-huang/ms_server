<?php
/**
 * @Author: 特筹网
 * @Date:   2016-08-12 16:56:23
 * @Last Modified by:   gangan
 * @Last Modified time: 2016-08-12 17:35:57
 */
namespace OSS\Model;

/**
 * Class PrefixInfo
 *
 * listObjects接口中返回的Prefix列表中的类
 * listObjects接口返回数据中包含两个Array:
 * 一个是拿到的Object列表【可以理解成对应文件系统中的文件列表】
 * 一个是拿到的Prefix列表【可以理解成对应文件系统中的目录列表】
 *
 * @package OSS\Model
 * @link http://help.aliyun.com/document_detail/oss/api-reference/bucket/GetBucket.html
 */
class PrefixInfo
{
    /**
     * PrefixInfo constructor.
     * @param string $prefix
     */
    public function __construct($prefix)
    {
        $this->prefix = $prefix;
    }

    /**
     * @return string
     */
    public function getPrefix()
    {
        return $this->prefix;
    }

    private $prefix;
}