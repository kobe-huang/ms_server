<?php
/**
 * @Author: 特筹网
 * @Date:   2016-08-12 16:56:23
 * @Last Modified by:   gangan
 * @Last Modified time: 2016-08-12 17:36:10
 */

namespace OSS\Model;

/**
 * Interface XmlConfig
 * @package OSS\Model
 */
interface XmlConfig
{

    /**
     * 接口定义，实现此接口的类都需要实现从xml数据解析的函数
     *
     * @param string $strXml
     * @return null
     */
    public function parseFromXml($strXml);

    /**
     * 接口定义，实现此接口的类，都需要实现把子类序列化成xml字符串的接口
     *
     * @return string
     */
    public function serializeToXml();

}
