<?php
/**
 * @Author: 特筹网
 * @Date:   2016-08-12 16:56:23
 * @Last Modified by:   gangan
 * @Last Modified time: 2016-08-12 17:35:07
 */

namespace OSS\Model;

/**
 * Class BucketListInfo
 *
 * ListBuckets接口返回的数据类型
 *
 * @package OSS\Model
 */
class BucketListInfo
{
    /**
     * BucketListInfo constructor.
     * @param array $bucketList
     */
    public function __construct(array $bucketList)
    {
        $this->bucketList = $bucketList;
    }

    /**
     * 得到BucketInfo列表
     *
     * @return BucketInfo[]
     */
    public function getBucketList()
    {
        return $this->bucketList;
    }

    /**
     * BucketInfo信息列表
     *
     * @var array
     */
    private $bucketList = array();
}