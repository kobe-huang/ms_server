<?php
/**
 * @Author: 特筹网
 * @Date:   2016-08-12 16:56:23
 * @Last Modified by:   gangan
 * @Last Modified time: 2016-08-12 17:35:45
 */
namespace OSS\Model;

/**
 *
 * Class ObjectInfo
 *
 * listObjects接口中返回的Object列表中的类
 *
 * listObjects接口返回数据中包含两个Array
 * 一个是拿到的Object列表【可以理解成对应文件系统中的文件列表】
 * 一个是拿到的Prefix列表【可以理解成对应文件系统中的目录列表】
 *
 * @package OSS\Model
 */
class ObjectInfo
{
    /**
     * ObjectInfo constructor.
     *
     * @param string $key
     * @param string $lastModified
     * @param string $eTag
     * @param string $type
     * @param int $size
     * @param string $storageClass
     */
    public function __construct($key, $lastModified, $eTag, $type, $size, $storageClass)
    {
        $this->key = $key;
        $this->lastModified = $lastModified;
        $this->eTag = $eTag;
        $this->type = $type;
        $this->size = $size;
        $this->storageClass = $storageClass;
    }

    /**
     * @return string
     */
    public function getKey()
    {
        return $this->key;
    }

    /**
     * @return string
     */
    public function getLastModified()
    {
        return $this->lastModified;
    }

    /**
     * @return string
     */
    public function getETag()
    {
        return $this->eTag;
    }

    /**
     * @return string
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * @return int
     */
    public function getSize()
    {
        return $this->size;
    }

    /**
     * @return string
     */
    public function getStorageClass()
    {
        return $this->storageClass;
    }

    private $key = "";
    private $lastModified = "";
    private $eTag = "";
    private $type = "";
    private $size = 0;
    private $storageClass = "";
}